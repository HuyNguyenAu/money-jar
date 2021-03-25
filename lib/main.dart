import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Coin Jars'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _balance = 0.01;
  final myController = TextEditingController();

  void _updateBalance(bool spend) {
    double amount = double.tryParse(myController.text);

    if (amount == null) {
      _showMessageDialog('Error', 'Invalid number was entered.', this.context);
      return;
    } else {
      amount = amount.abs();
    }

    if (spend) {
      amount *= -1.0;
    }

    setState(() {
      _balance += amount;
    });
  }

  void _showMessageDialog(String title, String message, BuildContext context) {
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

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void displayBottomSheet(BuildContext context, bool spend) {
    myController.text = '';
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
                            controller: myController,
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
                          onPressed: () => {_updateBalance(spend)},
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
              '${_balance.toStringAsFixed(2)}',
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
                      flex: 3,
                    ),
                    Text(
                      'ADD TO BALANCE',
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
              onPressed: () => displayBottomSheet(context, false),
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
                      'SPEND',
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
              onPressed: () => displayBottomSheet(context, true),
            ),
            Spacer(flex: 12),
          ],
        ),
      ),
    );
  }
}
