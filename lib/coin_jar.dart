import 'package:flutter/material.dart';
import 'widgets.dart';

class CoinJarPage extends StatefulWidget {
  CoinJarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CoinJarPageState createState() => CoinJarPageState();
}

class CoinJarPageState extends State<CoinJarPage> {
  double balance = 0;
  final amountTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 12),
            Text(
              '${balance.toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w400),
            ),
            Spacer(flex: 2),
            Widgets.largeButton(
                'Deposit', () => {showBottomSheet(context, false)}, context),
            Spacer(flex: 1),
            Widgets.largeButton(
                'Spend', () => {showBottomSheet(context, true)}, context),
            Spacer(flex: 12),
          ],
        ),
      ),
    );
  }

  void updateBalance(bool spend, BuildContext context) {
    double amount = double.tryParse(amountTextFieldController.text);

    if (amount == null) {
      Widgets.showMessageDialog(
          'Error', 'Invalid number was entered.', context);
      return;
    } else if (amount <= 0) {
      Widgets.showMessageDialog(
          'Error', 'Amount must be greater than 0.', context);
      return;
    }

    if (spend) {
      amount *= -1;
    }

    setState(() {
      balance += amount;
    });
  }

  void showBottomSheet(BuildContext context, bool spend) {
    Widgets.showBottomModal(
        spend ? 'Pay With Funds' : 'Deposit Funds',
        spend ? 'Pay' : 'Deposit',
        () => {updateBalance(spend, context)},
        amountTextFieldController,
        context);
  }

  @override
  void dispose() {
    amountTextFieldController.dispose();
    super.dispose();
  }
}
