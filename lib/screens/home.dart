import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'TelaDados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> buttons = [];

  void fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('assunto').orderBy('normalized_nome').get();
    List<Widget> fetchedButtons = snapshot.docs.map((doc) {
      return Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Center(
            child:
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30), //border raiuds of dropdown button
                  boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        blurRadius: 5) //blur radius of shadow
                  ]
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(200, 40)),
                    backgroundColor: WidgetStateProperty.all(corFundo,
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaDados(assuntoSerie: doc['normalized_nome'],)
                        )
                    );
                  },
                  child: Text(doc['nome'], style: TextStyle(fontSize: 16, color: Colors.white),)
              ),
            ),
          )
      );
    }).toList();
    setState(() {
      buttons = fetchedButtons;
    });
  }

  Future<void> _launchUrl() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'dados.economicos156@gmail.com',
      query: 'subject=Contato',
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch $emailUri');
    }
  }

  @override
  void initState() {
    fetchData();
  }

  var corFundo = Color.fromARGB(255, 63, 81, 181);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha o assunto", style: TextStyle(color: Colors.white)),
        backgroundColor: corFundo,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body:
      Column(
        children: buttons
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 63, 81, 181)
              ),
              child: Text("Menu", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Ajuda e feedback"),
              onTap: (){
                _launchUrl();
              },
            )
          ],
        ),
      ),
    );
  }
}