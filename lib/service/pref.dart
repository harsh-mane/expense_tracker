import 'dart:convert';
import 'dart:developer';

import 'package:expense_tracker/model/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static late final SharedPreferences _pref;

  static Future<void> initPref() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<void> storeList(List<Transaction> list) async {
    await _pref.setString('transactionHistory', jsonEncode(list));
  }

  static List<Transaction> getList() {
    try {
      final list = _pref.getString('transactionHistory');
      log('$list', name: 'list');
      // final data = jsonDecode(list ?? '[]');

      // final temp = <Transaction>[];

      // for (final i in data) {
      //   temp.add(Transaction.fromJson(i));
      // }

      // return temp;

      return List.from(jsonDecode(list ?? '[]'))
          .map((e) => Transaction.fromJson(e))
          .toList();
    } catch (e) {
      log('$e');
      return [];
    }
  }
}
