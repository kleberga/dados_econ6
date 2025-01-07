import 'package:flutter/material.dart';
import 'TelaDados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

*//*  void preencherDados() async {
    for(var i = 0; i<listaSeries.length; i++){
      var numeroSerie = listaSeries[i].numero;
      var fido = Toggle_reg(id: numeroSerie, valorToggle: 0, dataCompara: '');
      await DatabaseHelper.insertToggle(fido);
      setState(() {
        progress = i/listaSeries.length;
      });
    }
  }*//*


  @override
  void initState() {
    // chamar a função anterior
    //preencherDados();
  }

  var corFundo = Color.fromARGB(255, 63, 81, 181);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha o assunto", style: TextStyle(color: Colors.white)),
        // backgroundColor: Color.fromRGBO(63, 81, 181, 20),
        backgroundColor: corFundo,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Column(
        children: <Widget>[
      *//*            LinearProgressIndicator(
          minHeight: 25,
          value: progress,
          semanticsLabel: (progress * 100).toString(),
          semanticsValue: (progress * 100).toString(),
      ),*//*
          Padding(
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
                    //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                    // backgroundColor: WidgetStateProperty.all(Color.fromRGBO(63, 81, 181, 20),
                    backgroundColor: WidgetStateProperty.all(corFundo,
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaDados(assuntoSerie: 'Índice de preços',)
                        )
                    );
                  },
                  child: Text("Índices de preços", style: TextStyle(fontSize: 16, color: Colors.white),)
              ),
            ),
          )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Setor real',)
                            )
                        );
                      },
                      child: Text("Setor real", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Mercado de trabalho',)
                            )
                        );
                      },
                      child: Text("Mercado de trabalho", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Setor externo',)
                            )
                        );
                      },
                      child: Text("Setor externo", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Dados monetários',)
                            )
                        );
                      },
                      child: Text("Dados monetários", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}*/



class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> buttons = [];
/*  void preencherDados() async {
    for(var i = 0; i<listaSeries.length; i++){
      var numeroSerie = listaSeries[i].numero;
      var fido = Toggle_reg(id: numeroSerie, valorToggle: 0, dataCompara: '');
      await DatabaseHelper.insertToggle(fido);
      setState(() {
        progress = i/listaSeries.length;
      });
    }
  }*/
  void fetchData() async {
    // Initialize Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference the collection you want to query
    QuerySnapshot snapshot = await firestore.collection('assunto').orderBy('normalized_nome').get();

    // Convert the query results into a list of DadosSeries objects
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
                    //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                    // backgroundColor: WidgetStateProperty.all(Color.fromRGBO(63, 81, 181, 20),
                    backgroundColor: WidgetStateProperty.all(corFundo,
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaDados(assuntoSerie: doc['id'],)
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

  @override
  void initState() {
    // chamar a função anterior
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
      ),
      body:
      Column(
        children: buttons /*<Widget>[
          *//*            LinearProgressIndicator(
          minHeight: 25,
          value: progress,
          semanticsLabel: (progress * 100).toString(),
          semanticsValue: (progress * 100).toString(),
      ),*//*
          Padding(
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        // backgroundColor: WidgetStateProperty.all(Color.fromRGBO(63, 81, 181, 20),
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Índice de preços',)
                            )
                        );
                      },
                      child: Text("Índices de preços", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Setor real',)
                            )
                        );
                      },
                      child: Text("Setor real", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Mercado de trabalho',)
                            )
                        );
                      },
                      child: Text("Mercado de trabalho", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Setor externo',)
                            )
                        );
                      },
                      child: Text("Setor externo", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.all(10),
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
                        //backgroundColor: MaterialStateProperty.all(Colors.grey[200],
                        backgroundColor: WidgetStateProperty.all(corFundo,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaDados(assuntoSerie: 'Dados monetários',)
                            )
                        );
                      },
                      child: Text("Dados monetários", style: TextStyle(fontSize: 16, color: Colors.white),)
                  ),
                ),
              )
          ),
        ],*/
      ),
    );
  }
}




