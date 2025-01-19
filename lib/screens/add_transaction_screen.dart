import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  final String? initialAmount;
  final String? initialDescription;

  const AddTransactionScreen({super.key, this.initialAmount, this.initialDescription});

  @override
  AddTransactionScreenState createState() => AddTransactionScreenState();
}

class AddTransactionScreenState extends State<AddTransactionScreen> {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.initialAmount);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  void _addTransaction() {
    if (_amountController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
      );
      return;
    }

    final String formattedTime = DateTime.now().toString();
    Navigator.pop(context, {
      'amount': _amountController.text,
      'description': _descriptionController.text,
      'time': formattedTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm giao dịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Số tiền'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTransaction,
              child: const Text('Thêm giao dịch'),
            ),
          ],
        ),
      ),
    );
  }
}
