import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:dados_economicos6/variables_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../screens/TelaDados.dart';
import '../infra/database_helper.dart';

// Define the Notification Service class
/*
class NotificationService {
  // Initialize the FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialization method for notifications
  Future<void> initNotification() async {
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettingsAndroid = AndroidInitializationSettings('icone_economico');

    var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle your notification response here
      },
    );
  }

  // Notification details method
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  // Method to show notification
  Future showNotification({int id = 0, String? title, String? body, String? payLoad}) async {
    return flutterLocalNotificationsPlugin.show(
      id, title, body, await notificationDetails(),
    );
  }
}
*/

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('icone_economico');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(),
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

Future loadDataSGS2() async {
  String jsonString = await getJsonFromRestAPI2();
  final jsonResponse = json.decode(jsonString);
  for (Map<String, dynamic> i in jsonResponse){
    listaBack.add(serie_app.fromJson(i));
  }
}

Future loadDataIBGE2() async {
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
}

NumberFormat formatter1 = new NumberFormat("00");
NumberFormat formatter2 = new NumberFormat("0000");

//List<Toggle_reg>? valorToggleBack;
var dataArmazenada;
List<Toggle_reg>? valorData;


/*@pragma('vm:registry-point')
void onStart1(ServiceInstance service1) async {
*//*  DartPluginRegistrant.ensureInitialized();
  if(service1 is AndroidServiceInstance){
    service1.on("setAsForeground").listen((event) {
      service1.setAsForegroundService();
    });
    service1.on("setAsBackground").listen((event) {
      service1.setAsBackgroundService();
    });
  }
  service1.on("stopService").listen((event) {
    service1.stopSelf();
  });*//*

  DartPluginRegistrant.ensureInitialized();

  // Initialize the notification service
  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  // Define the notification details
  var notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  // Start the foreground service with a notification
  if (service1 is AndroidServiceInstance) {
    service1.setAsForegroundService();

    // Show the notification to the user
    notificationService.flutterLocalNotificationsPlugin.show(
      1,
      'My Service',
      'Running in the background',
      notificationDetails,
    );

    service1.on("setAsForeground").listen((event) {
      service1.setAsForegroundService();
    });

    service1.on("setAsBackground").listen((event) {
      service1.setAsBackgroundService();
    });
  }

    service1.on("stopService").listen((event) {
      service1.stopSelf();
    });

    // Simulate some work
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      service1.invoke('update', {'current': i});
    }

  Future recuperaData() async {
    valorData = await DatabaseHelper.getAllToggle();
  }
  recuperaData();


  //NotificationService().initNotification();
  Timer.periodic(const Duration(seconds: 1), (timer) async {
*//*    if(service1 is AndroidServiceInstance){
      if(await service1.isForegroundService()){
        service1.setForegroundNotificationInfo(title: "SCRIPT ACADEMY", content: "sub my channel");
      }
    }*//*
      // perfom some operation on background which is not noticeable to the user everytime
      //print("background service running");

    var ultimaData;


    //print("valorData: $valorData");

      //var listaEscolhida = Provider.of<ListaMeusDados>(context, listen: true).getListaEscolhida;

    //var listaMeusDados = providerContainer.read(listaMeusDadosProvider);
    //listaEscolhida = listaMeusDados.getListaEscolhida;

    nomeSerieArmaz = await getStringFromLocalStorage("nomeSerieArmaz");
    urlSerieArmaz = await getStringFromLocalStorage("urlSerieArmaz");
    fonteSerieArmaz = await getStringFromLocalStorage("fonteSerieArmaz");

    metricaArmaz = await getStringFromLocalStorage("metricaArmaz");
    localidadeArmaz = await getStringFromLocalStorage("localidadeArmaz");
    categoriaArmaz = await getStringFromLocalStorage("categoriaArmaz");


    //print(listaEscolhida);
*//*      if (listaEscolhida.isEmpty) {
        print("listaEscolhida is empty. Data might not have been loaded yet.");
        return;
      }*//*
      for(var i = 0; i< valorData!.length; i++){
        if(valorData![i].valorToggle==1){
          cod_serie = valorData![i].id;
          urlSerie = urlSerieArmaz;
          fonte = fonteSerieArmaz;
          if(fonte=="IBGE"){
            loadDataIBGE2();
          } else {
            loadDataSGS2();
          }
          if(listaBack.isNotEmpty){
            ultimaData = listaBack.last.data.toString();
          } else {
            print("lista vazia");
          }


          dataArmazenada = valorData?.firstWhere((element) => element.id==cod_serie).dataCompara;

          //dataArmazenada = '2023-12-01 00:00:00.000';

          valorToggleDB = valorData?.firstWhere((element) => element.id==cod_serie).valorToggle;

          print("background service running $ultimaData");
          print("url da serie: $urlSerie");
          print("dataArmazenada: $dataArmazenada");

          //var nomeSerie = listaEscolhida.firstWhere((element) => element.numero==cod_serie).nome;


          print("ultimaData: $ultimaData");
          if(dataArmazenada!=null && ultimaData!=null && (ultimaData!=dataArmazenada)){
            NotificationService().showNotification(title: 'Atualização de série', body: "A série  '$nomeSerieArmaz - $metricaArmaz - $localidadeArmaz - $categoriaArmaz' foi atualizada!");
            await DatabaseHelper.insertToggle(Toggle_reg(id: cod_serie, valorToggle: valorToggleDB, dataCompara: ultimaData.toString()));
          }
        }
      }



    });
}*/


/*
@pragma('vm:entry-point')
void onStart1(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  var notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'icone_economico',
    ),
    iOS: DarwinNotificationDetails(),
  );

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();

    notificationService.flutterLocalNotificationsPlugin.show(
      1,
      'Dados Econômicos',
      'O serviço de notificação desta série foi ativado!',
      notificationDetails,
    );

    service.on("setAsForeground").listen((event) {
      service.setAsForegroundService();
    });

    service.on("setAsBackground").listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Future recuperaData() async {
    valorData = await DatabaseHelper.getAllToggle();
  }
  recuperaData();

  Timer.periodic(const Duration(seconds: 1), (timer) async {
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
          loadDataIBGE2();
        } else {
          loadDataSGS2();
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

*/
/*        if (dataArmazenada != null && ultimaData != null && (ultimaData != dataArmazenada)) {
          NotificationService().showNotification(
              title: 'Atualização de série',
              body: "A série '$nomeSerieArmaz - $metricaArmaz - $localidadeArmaz - $categoriaArmaz' foi atualizada!"
          );
          await DatabaseHelper.insertToggle(Toggle_reg(
              id: cod_serie,
              valorToggle: valorToggleDB,
              dataCompara: ultimaData.toString()
          ));
        }*//*

        if (true) {
          NotificationService().showNotification(
              title: 'Atualização de série',
              body: "A série '$nomeSerieArmaz - $metricaArmaz - $localidadeArmaz - $categoriaArmaz' foi atualizada!"
          );
          await DatabaseHelper.insertToggle(Toggle_reg(
              id: cod_serie,
              valorToggle: valorToggleDB,
              dataCompara: ultimaData.toString()
          ));
        }
      }
    }
  });
}
*/


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
      icon: 'icone_economico',
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

  Timer.periodic(const Duration(seconds: 1), (timer) async {
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

        if (dataArmazenada != null && ultimaData != null && (ultimaData != dataArmazenada)) {
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



