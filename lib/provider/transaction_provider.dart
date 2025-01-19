import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../db/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<UserTransaction> _transactions = [];
  List<UserTransaction> get transactions => _transactions;
  Future<void> fetchTransactions() async {
    _transactions = await DatabaseHelper.instance.getTransactions();
    notifyListeners();
  }
  Future<void> addTransaction(UserTransaction transaction) async {
    await DatabaseHelper.instance.insertTransaction(transaction);
    fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await DatabaseHelper.instance.deleteTransaction(id);
    fetchTransactions();
  }
  void addSampleData() {
    _transactions.addAll([
      UserTransaction(title: "Mua cà phê", amount: 30000, date: DateTime.now(), isIncome: false),
      UserTransaction(title: "Nhận lương", amount: 5000000, date: DateTime.now(), isIncome: true),
    ]);
    notifyListeners();
  }
}
