import 'dart:io';

import 'package:dados_economicos6/screens/TelaDados.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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

class DescricaoSeries extends StatefulWidget {

  final String cod_series;
  const DescricaoSeries({Key? key, required this.cod_series}) : super(key: key);
  const DescricaoSeries.otherConstructor(this.cod_series);

  @override
  State<DescricaoSeries> createState() => _DescricaoSeriesState();
}

class _DescricaoSeriesState extends State<DescricaoSeries> {
  InterstitialAd? _interstitialAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        )

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {

    _interstitialAd?.show();

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
                title: Text(listaEscolhida.firstWhere((element) => element.numero==widget.cod_series ).nomeCompleto,
                  style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: '\nDescrição: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).descricao), // Remaining text
                        TextSpan(text: '\n'), // Remaining text
                        TextSpan(text: '\nNível geográfico: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).nivelGeografico), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nLocalidade: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).localidades), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nGrupo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).categoria), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nForma de cálculo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).metrica), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nFormato da série: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).formato), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nPeriodicidade de divulgação: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).periodicidade), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nPeríodo disponível: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'entre $dataInicialSerie e $dataFinalSerie'), // Remaining text
                        TextSpan(text: '\n'),
                        TextSpan(text: '\nFonte dos dados: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: listaEscolhida.firstWhere((element) => element.numero==widget.cod_series).fonte), // Remaining text
                        TextSpan(text: '\n'),
                      ], style: DefaultTextStyle.of(context).style, ),
                  textAlign: TextAlign.justify,
                ),
              );
            },
          ),
        )
    );
  }
}