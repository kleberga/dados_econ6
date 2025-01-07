import 'package:flutter/foundation.dart';
import '../model/model.dart';

class ListaMeusDados extends ChangeNotifier {
  List<DadosSeries> _listaEscolhida = [];

  List<DadosSeries> get getListaEscolhida => _listaEscolhida;

  void setListaEscolhida(List<DadosSeries> value) {
    _listaEscolhida = value;
    notifyListeners();
  }
}

