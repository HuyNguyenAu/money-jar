import 'package:flutter/material.dart';
import 'widgets.dart';

class CoinJarPage extends StatefulWidget {
  CoinJarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CoinJarPageState createState() => CoinJarPageState();
}

class CoinJarPageState extends State<CoinJarPage> {
  final textFieldController = TextEditingController();
  double balance = 0;
  double goal = 0;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      accountWidget(textFieldController, context),
      goalWidget(textFieldController, context)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Account'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: 'Goal'),
        ],
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          })
        },
        currentIndex: currentIndex,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void updateBalance(
      bool spend, TextEditingController controller, BuildContext context) {
    double amount = double.tryParse(controller.text);

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

      if ((balance + amount) < 0) {
        Widgets.showMessageDialog('Error', 'Insuffiencent funds.', context);
        return;
      }
    }

    setState(() {
      balance += amount;
    });
  }

  void updateGoal(TextEditingController controller, BuildContext context) {
    double amount = double.tryParse(controller.text);

    if (amount == null) {
      Widgets.showMessageDialog(
          'Error', 'Invalid number was entered.', context);
      return;
    } else if (amount <= 0) {
      Widgets.showMessageDialog(
          'Error', 'Amount must be greater than 0.', context);
      return;
    }

    setState(() {
      goal = amount;
    });
  }

  Center accountWidget(TextEditingController controller, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 12),
          Text(
            '${balance.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400),
          ),
          Spacer(flex: 2),
          Widgets.largeButton('Deposit', () {
            Widgets.showBottomModal('Deposit Funds', 'Deposit', () {
              updateBalance(false, controller, context);
            }, controller, context);
          }, context),
          Spacer(flex: 1),
          Widgets.largeButton('Spend', () {
            Widgets.showBottomModal('Pay With Funds', 'Pay', () {
              updateBalance(true, controller, context);
            }, controller, context);
          }, context),
          Spacer(flex: 12),
        ],
      ),
    );
  }

  Center goalWidget(TextEditingController controller, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 12),
          Text(
            '${goal.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400),
          ),
          Spacer(flex: 2),
          Widgets.largeButton('Adjust', () {
            Widgets.showBottomModal('Adjust Goal', 'Adjust', () {
              updateGoal(controller, context);
            }, controller, context);
          }, context),
          Spacer(flex: 12),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }
}
