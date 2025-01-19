import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:qlthuchi/provider/transaction_provider.dart';

void main() {
  final transactionProvider = TransactionProvider();
  transactionProvider.addSampleData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Thu Chi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const HomeScreen(),
    );
  }
}
