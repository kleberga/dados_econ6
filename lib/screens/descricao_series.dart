import 'package:dados_economicos6/screens/TelaDados.dart';
import 'package:flutter/material.dart';

var corFundo = Color.fromARGB(255, 63, 81, 181);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toLowerCase()}${this.substring(1)}";
  }
}

extension StringExtension2 on String {
  String capitalize2() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class DescricaoSeries extends StatelessWidget {

  final String cod_series;
  const DescricaoSeries({Key? key, required this.cod_series}) : super(key: key);
  const DescricaoSeries.otherConstructor(this.cod_series);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Descrição da série", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: corFundo,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listaEscolhida.firstWhere((element) => element.numero==cod_series ).nomeCompleto,
              style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("\nDescrição: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).descricao+
                  "\n"+
                  "\nNível geográfico: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).nivelGeografico +
                  "\n"+
                  "\nLocalidade: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).localidades +
                  "\n"+
                  "\nGrupo: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).categoria +
                  "\n"+
                  "\nForma de cálculo: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).metrica+
                  "\n"+
                  "\nFormato da série: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).formato+
                  "\n"+
                  "\nPeriodicidade de divulgação: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).periodicidade +
                  "\n"+
                  "\nPeríodo disponível: entre $dataInicialSerie e $dataFinalSerie" +
                  "\n"+
                  "\nFonte dos dados: "+listaEscolhida.firstWhere((element) => element.numero==cod_series).fonte+
                  "\n",
                textAlign: TextAlign.justify,
              ),
            );
          },
        ),
      )

    );
  }
}
