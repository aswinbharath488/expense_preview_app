import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/transaction_model.dart';

class TransactionLocalDataSource {
  Future<List<TransactionModel>> loadJson() async {
    await Future.delayed(Duration(milliseconds: 700));
    final jsonString = await rootBundle.loadString('assets/transactions.json');
    final dataList = json.decode(jsonString) as List;
    return dataList.map((e) => TransactionModel.fromJson(e)).toList();
  }
}
