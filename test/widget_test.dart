import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:qlthuchi/provider/transaction_provider.dart';
import 'package:qlthuchi/screens/add_transaction_screen.dart';

void main() {
  testWidgets('Thêm giao dịch và hiển thị giao dịch', (WidgetTester tester) async {
    final transactionProvider = TransactionProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: transactionProvider,
        child: MaterialApp(home: AddTransactionScreen()),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Thêm'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), 'Mua hàng');
    await tester.enterText(find.byType(TextField).at(1), '100.0');
    await tester.tap(find.text('Thêm'));
    await tester.pumpAndSettle();
    expect(transactionProvider.transactions.length, 1);
    expect(transactionProvider.transactions[0].title, 'Mua hàng');
    expect(transactionProvider.transactions[0].amount, 100.0);
  });
}
