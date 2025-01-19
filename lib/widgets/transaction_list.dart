import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/transaction_provider.dart';
class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (ctx, transactionProvider, child) {
        final transactions = transactionProvider.transactions;

        if (transactions.isEmpty) {
          return const Center(child: Text("Chưa có giao dịch nào!"));
        }

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            final tx = transactions[index];
            return ListTile(
              title: Text(tx.title),
              subtitle: Text("${tx.amount} VND"),
              trailing: tx.isIncome
                  ? const Icon(Icons.arrow_upward, color: Colors.green)
                  : const Icon(Icons.arrow_downward, color: Colors.red),
            );
          },
        );
      },
    );
  }
}