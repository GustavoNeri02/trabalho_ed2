import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_ed2/extensions/icon_data_extension.dart';
import 'package:uuid/uuid.dart';

class TabelaHash {
  TabelaHash._privateConstructor();

  static final TabelaHash _instance = TabelaHash._privateConstructor();

  factory TabelaHash() {
    return _instance;
  }

  Map<String, IconData> tabelaHash = {};
  final String chaveArmazenamento = 'tabelaHash';

  Future<List<IconData>> carregarIconesDaHash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dadosSalvos = prefs.getString(chaveArmazenamento);

    if (dadosSalvos != null) {
      final Map<String, dynamic> result = json.decode(dadosSalvos);
      List<IconData> listaSalva = [];
      result.forEach((key, map) {
        listaSalva.add(IconData(
          map['codePoint'],
          fontFamily: map['fontFamily'],
          fontPackage: map["fontPackage"],
          matchTextDirection: map['matchTextDirection'],
        ));
      });
      return listaSalva;
    }
    return [];
  }

  Future<bool> salvarDadosNaHash() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final value =
          tabelaHash.map((key, value) => MapEntry(key, value.toJson()));
      String dadosParaSalvar = json.encode(value);

      prefs.setString(chaveArmazenamento, dadosParaSalvar);
      return true;
    } catch (_) {
      return false;
    }
  }

  void adicionarNaTabelaHash(IconData iconData) {
    final uniqueID = const Uuid().v4();
    tabelaHash.addEntries([MapEntry(uniqueID, iconData)]);
  }
}
