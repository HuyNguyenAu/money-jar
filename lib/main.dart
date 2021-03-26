import 'package:flutter/material.dart';
import 'styles.dart';
import 'widgets.dart';
import 'coin_jar.dart';

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
        title: 'Home',
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

class HomePageState extends State<HomePage> {
  final List<Map<String, String>> entries = <Map<String, String>>[
    {
      'Name': 'HECS',
      'Balance': '10',
    },
    {
      'Name': 'Rego',
      'Balance': '10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 50,
              child: Center(child: Text('${entries[index]['Type']}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        )));
  }
}
