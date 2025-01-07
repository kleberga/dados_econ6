import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dados_economicos6/variables_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'screens/TelaDados.dart';
import 'service/back_services.dart';
import 'screens/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infra/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  // and layout of widgets. It also manages the widget tree, a hierarchy of widgets
  // that Flutter uses to choose which widgets to render and how to render them.
  // The WidgetsFlutterBinding class also interacts with the native code of the
  // platform it's running on.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var db = FirebaseFirestore.instance;

  DateTime now = DateTime.now();
  String formattedDateTime = DateFormat('yyyy-MM-dd_HH:mm:ss.SSS').format(now);
  print(formattedDateTime);

  var listaSeries =
  <String, dynamic>{
      'numero': formattedDateTime,
      'nome': 'Índice Nacional de Preços ao Consumidor (INPC)',
      'nomeCompleto': 'Índice Nacional de Preços ao Consumidor (INPC)',
      'descricao': 'O INPC tem por objetivo a correção do poder de compra dos salários, através da mensuração das variações de preços da cesta de consumo da população assalariada com mais baixo rendimento. Atualmente, a população-objetivo do INPC abrange as famílias com rendimentos de 1 a 5 salários mínimos, cuja pessoa de referência é assalariada, residentes nas regiões metropolitanas de Belém, Fortaleza, Recife, Salvador, Belo Horizonte, Vitória, Rio de Janeiro, São Paulo, Curitiba, Porto Alegre, além do Distrito Federal e dos municípios de Goiânia, Campo Grande, Rio Branco, São Luís e Aracaju.',
      'formato': '%',
      'fonte': 'IBGE',
      'urlAPI': 'https://servicodados.ibge.gov.br/api/v3/agregados/1736/periodos/all/variaveis/44?localidades=N1[1]',
      'idAssunto': 1,
      'periodicidade': 'mensal',
      'metrica': 'Variação mensal',
      'nivelGeografico': 'Brasil',
      'localidades': 'Brasil',
      'categoria': 'Índice geral'
  };


  // Create a new user with a first and last name
/*  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };*/

// Add a new document with a generated ID
/*  db.collection("metadados").add(listaSeries).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));*/
  // função para preencher a tabela SQL com os dados das séries
/*  void preencherDados() async {
    for(var i = 0; i<listaSeries.length; i++){
      var numeroSerie = listaSeries[i].numero;
      var fido = Toggle_reg(id: numeroSerie, valorToggle: 0, dataCompara: '');
      await DatabaseHelper.insertToggle(fido);
      progress = i/listaSeries.length;
    }
  }
  // chamar a função anterior
  preencherDados();*/

  NotificationService().initNotification();
  await Permission.notification.isDenied.then(
        (value){
      if(value){
        Permission.notification.request();
      }
    },
  );

  isNotificationGranted = await Permission.notification.isGranted;

  runApp(
      ProviderScope(
        parent: providerContainer,
      child: MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    )
);
}



