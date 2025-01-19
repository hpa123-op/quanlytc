import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/transaction_provider.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    if (transactions.isEmpty) {
      return const Center(
        child: Text("Không có dữ liệu để hiển thị!"),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: const Text("Biểu đồ thu chi sẽ hiển thị ở đây"), // Placeholder
    );
  }
}
