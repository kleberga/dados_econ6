import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:dados_economicos6/model/variables_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../screens/TelaDados.dart';
import '../infra/database_helper.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('icone_economico');
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );


    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'channelId',
        'channelName',
        importance: Importance.max,
      );

      final AndroidFlutterLocalNotificationsPlugin? androidFlutterLocalNotificationsPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      if (androidFlutterLocalNotificationsPlugin != null) {
        await androidFlutterLocalNotificationsPlugin.createNotificationChannel(channel);
      }
    }
  }

  Future<void> showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'icone_economico',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
//====================================================================================

var service1;

Future<void> initializeService1() async {
  // Ensure this function is called in the main isolate
  if (Isolate.current.debugName == 'main') {
    if (service1 != null && await service1.isRunning()) { print("Service is already running."); return; }
    service1 = FlutterBackgroundService();
    await service1.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart1,
        onBackground: onIosBackground1,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart1,
        isForegroundMode: true,
        autoStart: true,
      ),
    );
  } else {
    throw Exception('This class should only be used in the main isolate (UI App).');
  }
}

var urlSerie;
var cod_serie;
var fonte;
var valorToggleDB;
var metricaArmaz;
var localidadeArmaz;
var categoriaArmaz;

var nomeSerieArmaz;
var urlSerieArmaz;
var fonteSerieArmaz;

Future<String> getJsonFromRestAPI2() async {
  //String? urlSerie = await getStringFromLocalStorage("urlSerieArmaz");
  String url = urlSerie;
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

@pragma('vm:registry-point')
Future<bool> onIosBackground1(ServiceInstance service1) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

List<serie_app> listaBack = [];
//var ultimaData;

NumberFormat formatter1 = new NumberFormat("00");
NumberFormat formatter2 = new NumberFormat("0000");

Future loadDataSGS2() async {
  String jsonString = await getJsonFromRestAPI2();
  var jsonString2 = jsonString.replaceAll('<?xml version="1.0" encoding="pt-br"?>', '');
  jsonString2 = jsonString2.replaceAll('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"', '');
  jsonString2 = jsonString2.replaceAll('"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">', '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"');
  jsonString2 = jsonString2.replaceAll('<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">', '');
  var pattern11 = RegExp(r'<head>\s*{[^}]*}');
  jsonString2 = jsonString2.replaceAll(pattern11, '');
  jsonString2 = jsonString2.replaceAll('<head>', '');
  jsonString2 = jsonString2.replaceAll('<title>Requisição inválida!</title>', '');
  jsonString2 = jsonString2.replaceAll('<link rev="made" />', '');
  jsonString2 = jsonString2.replaceAll('<style>', '');
  var pattern1 = RegExp(r'a:link\s*{[^}]*}');
  jsonString2 = jsonString2.replaceAll(pattern1, '');
  var pattern2 = RegExp(r'a:hover\s*{[^}]*}');
  jsonString2 = jsonString2.replaceAll(pattern2, '');
  var pattern4 = RegExp(r'a:active\s*{[^}]*}');
  jsonString2 = jsonString2.replaceAll(pattern4, '');
  var pattern5 = RegExp(r'a:visited\s*{[^}]*}');
  jsonString2 = jsonString2.replaceAll(pattern5, '');
  final jsonResponse = json.decode(jsonString2);
  for (Map<String, dynamic> i in jsonResponse){
    if(i['valor']!=""&&i['valor']!=null) {
      listaBack.add(serie_app.fromJson(i));
    }
  }
}

/*Future loadDataIBGE2() async {
  String jsonString = await getJsonFromRestAPI2();
  final jsonResponse = json.decode(jsonString);
  final item = jsonResponse[0]['resultados'][0]['series'][0]['serie'];
  for (var i = 0; i<item.keys.toList().length; i++){
    var x = item.keys.toList()[i];
    x = formatter1.format(int.parse(x.substring(4))) + "/" + formatter2.format(int.parse(x.substring(0, 4)));
    var y = item.values.toList()[i].toString();
    if(y!="..."&&y!="-"){
      listaBack.add(
          serie_app(
              DateFormat('MM/yyyy').parse(x),
              double.parse(y)
          )
      );
    }
  }
}*/

Future loadDataIBGE2() async {
  String jsonString = await getJsonFromRestAPI2();
  var pattern1 = RegExp(r'/* #4D749F */\s*{[^}]*}');
  var jsonString2 = jsonString.replaceAll(pattern1, '');
  final jsonResponse = json.decode(jsonString2);
  final item = jsonResponse[0]['resultados'][0]['series'][0]['serie'];
  for (var i = 0; i < item.keys
      .toList()
      .length; i++) {
    var x = item.keys.toList()[i];
    var w = formatter1.format(int.parse(x.substring(4)));
    if (periodicidade == "trimestral") {
      if (w == "01") {
        w = "03";
      } else if (w == "02") {
        w = "06";
      } else if (w == "03") {
        w = "09";
      } else {
        w = "12";
      }
    }
    x = w + "/" + formatter2.format(int.parse(x.substring(0, 4)));
    var y = item.values.toList()[i].toString();
    if (y != "..." && y != "-" && y != "X") {
      listaBack.add(
          serie_app(
              DateFormat('MM/yyyy').parse(x),
              double.parse(y)
          )
      );
    }
  }
}



//List<Toggle_reg>? valorToggleBack;
var dataArmazenada;
List<Toggle_reg>? valorData;

@pragma('vm:entry-point')
void onStart1(ServiceInstance service) async {
  print("Service onStart1 initiated.");

  DartPluginRegistrant.ensureInitialized();
  print("Dart Plugin Registrant initialized.");

  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();
  print("NotificationService initialized.");

  var notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  if (service is AndroidServiceInstance) {
    print("Setting service as foreground service...");
    service.setAsForegroundService();

    print("Showing notification...");
    await notificationService.flutterLocalNotificationsPlugin.show(
      1,
      'Dados Econômicos',
      'O serviço de notificação desta série foi ativado!',
      notificationDetails,
    );
    print("Notification should be shown now.");

    service.on("setAsForeground").listen((event) {
      print("Setting service as foreground again...");
      service.setAsForegroundService();
    });

    service.on("setAsBackground").listen((event) {
      print("Setting service as background...");
      service.setAsBackgroundService();
    });
  }

  service.on("stopService").listen((event) {
    print("Stopping service...");
    service.stopSelf();
  });

  Future recuperaData() async {
    valorData = await DatabaseHelper.getAllToggle();
    print("Data recovered: $valorData");
  }
  await recuperaData();

  Timer.periodic(const Duration(seconds: 10), (timer) async {
    var ultimaData;

    nomeSerieArmaz = await getStringFromLocalStorage("nomeSerieArmaz");
    urlSerieArmaz = await getStringFromLocalStorage("urlSerieArmaz");
    fonteSerieArmaz = await getStringFromLocalStorage("fonteSerieArmaz");

    metricaArmaz = await getStringFromLocalStorage("metricaArmaz");
    localidadeArmaz = await getStringFromLocalStorage("localidadeArmaz");
    categoriaArmaz = await getStringFromLocalStorage("categoriaArmaz");

    for (var i = 0; i < valorData!.length; i++) {
      if (valorData![i].valorToggle == 1) {
        cod_serie = valorData![i].id;
        urlSerie = urlSerieArmaz;
        fonte = fonteSerieArmaz;

        if (fonte == "IBGE") {
          print("Loading data from IBGE.");
          await loadDataIBGE2();
        } else {
          print("Loading data from SGS.");
          await loadDataSGS2();
        }

        if (listaBack.isNotEmpty) {
          ultimaData = listaBack.last.data.toString();
        } else {
          print("lista vazia");
        }

        dataArmazenada = valorData?.firstWhere((element) => element.id == cod_serie).dataCompara;
        valorToggleDB = valorData?.firstWhere((element) => element.id == cod_serie).valorToggle;

        print("background service running $ultimaData");
        print("url da serie: $urlSerie");
        print("dataArmazenada: $dataArmazenada");

        // dataArmazenada != null && ultimaData != null && (ultimaData != dataArmazenada)
        if (true) {
          print("Preparing to show notification...");
          await notificationService.showNotification(
              title: 'Atualização de série',
              body: "A série '$nomeSerieArmaz - $metricaArmaz - $localidadeArmaz - $categoriaArmaz' foi atualizada!"
          );
          print("Notification should be shown now.");

          await DatabaseHelper.insertToggle(Toggle_reg(
              id: cod_serie,
              valorToggle: valorToggleDB,
              dataCompara: ultimaData.toString()
          ));
          print("Database entry added.");
        }
      }
    }
  });
}



