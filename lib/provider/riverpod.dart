import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/ChangeNotifier.dart';

final listaMeusDadosProvider = ChangeNotifierProvider<ListaMeusDados>((ref) {
  return ListaMeusDados();
});
