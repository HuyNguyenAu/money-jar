import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Jar',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
      ),
      home: CoinJarPage(
        title: 'HECS',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class CoinJarPage extends StatefulWidget {
  CoinJarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CoinJarPageState createState() => CoinJarPageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class CoinJarPageState extends State<CoinJarPage> {
  double balance = 0;
  final amountTextFieldController = TextEditingController();

  @override
  void dispose() {
    amountTextFieldController.dispose();
    super.dispose();
  }

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
            ElevatedButton(
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      '+',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      'Add To Balance',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
              ),
              onPressed: () => showBottomSheet(context, false),
            ),
            Spacer(flex: 1),
            ElevatedButton(
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      '\$',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      'Spend',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
              ),
              onPressed: () => showBottomSheet(context, true),
            ),
            Spacer(flex: 12),
          ],
        ),
      ),
    );
  }

  void updateBalance(bool spend) {
    double amount = double.tryParse(amountTextFieldController.text);

    if (amount == null) {
      showMessageDialog('Error', 'Invalid number was entered.', this.context);
      return;
    }

    if (amount < 0) {
      showMessageDialog('Error', 'Amount must be less than 0.', this.context);
      return;
    }

    setState(() {
      balance += amount;
    });
  }

  void showMessageDialog(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void showBottomSheet(BuildContext context, bool spend) {
    amountTextFieldController.text = '';
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    Text(
                      spend ? 'Pay with Wallet' : 'Add Funds',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(flex: 1),
                    Row(
                      children: [
                        Spacer(flex: 1),
                        Container(
                          child: TextField(
                            controller: amountTextFieldController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 10, top: 10),
                              labelText:
                                  spend ? 'Amount Spent' : 'Amount To Add',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            color: Colors.grey[850],
                          ),
                        ),
                        Spacer(flex: 1),
                        ElevatedButton(
                          child: SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  spend ? '\$' : '+',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  spend ? 'Pay' : 'Add Funds',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 50,
                          ),
                          onPressed: () => {updateBalance(spend)},
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                    Spacer(flex: 1),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Colors.grey[900],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.black,
          );
        });
  }
}
