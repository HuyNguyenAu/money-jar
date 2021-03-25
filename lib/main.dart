import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0.01;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void displayBottomSheet(BuildContext context, bool spend) {
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
                        SizedBox(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText:
                                    spend ? 'Amount Spent' : 'Amount To Add'),
                            keyboardType: TextInputType.number,
                          ),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50,
                        ),
                        Spacer(flex: 1),
                        ElevatedButton(
                            onPressed: () => {},
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
                                    flex: 3,
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
                              width: MediaQuery.of(context).size.width * 0.242,
                              height: 50,
                            )),
                        Spacer(flex: 1),
                      ],
                    ),
                    Spacer(flex: 1),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0)),
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
              '\$${_counter.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline2,
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
