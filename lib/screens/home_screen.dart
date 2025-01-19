import 'package:flutter/material.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> transactionHistory = [];

  void _openAddTransactionScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
    );
    if (result != null) {
      setState(() {
        transactionHistory.add({
          'amount': result['amount'],
          'description': result['description'],
          'time': result['time'],
        });
      });
    }
  }

  void _editTransaction(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTransactionScreen(
        initialAmount: transactionHistory[index]['amount'],
        initialDescription: transactionHistory[index]['description'],
      )),
    );
    if (result != null) {
      setState(() {
        transactionHistory[index] = {
          'amount': result['amount'],
          'description': result['description'],
          'time': result['time'],
        };
      });
    }
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactionHistory.removeAt(index); // Xóa giao dịch tại vị trí index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Quản lý chi tiêu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _openAddTransactionScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Màu nút
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Thêm giao dịch', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: transactionHistory.isEmpty
                  ? const Text('Chưa có giao dịch nào', style: TextStyle(fontSize: 18))
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: transactionHistory.length,
                itemBuilder: (context, index) {
                  final transaction = transactionHistory[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        '${transaction['description']} - ${transaction['amount']}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Thời gian: ${transaction['time']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editTransaction(index), // Chỉnh sửa
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTransaction(index), // Xóa
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
