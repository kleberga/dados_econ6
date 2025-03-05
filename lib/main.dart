import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dados_economicos6/model/variables_class.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'screens/TelaDados.dart';
import 'service/back_services.dart';
import 'screens/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infra/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

List<cadastroSeries> listaIBGE = [];
List<Metrica> listaMetrica = [];
List<NivelGeografico> listaNivelGeografico = [];
List<Localidades> listaLocalidades = [];
List<Categorias> listaCategorias = [];
var listaCombinada;

final providerContainer = ProviderContainer();

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  // inicializar uma instancia de WidgetsFlutterBinding. In the Flutter framework,
  // the WidgetsFlutterBinding class plays a crucial role. It is responsible for
  // the application's lifecycle, handling input gestures, and triggering the build
  // and layout of widgets.
  WidgetsFlutterBinding.ensureInitialized();
  // final notificationService = NotificationService();
  // await notificationService.initNotification();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var db = FirebaseFirestore.instance;
  DateTime now = DateTime.now();
  String formattedDateTime = DateFormat('yyyy-MM-dd_HH:mm:ss.SSS').format(now);


  runApp(
      ProviderScope(
        //parent: providerContainer,
        overrides: [
          // Add any provider overrides here, if needed.
          // For example: myProvider.overrideWithValue(someValue),
        ],
        child: MaterialApp(
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [
            Locale('pt', 'BR'), // Portuguese (Brazil)
        ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate, // Add this for Cupertino widgets
          ],
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    )
);
}