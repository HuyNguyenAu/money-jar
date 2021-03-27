import 'package:flutter/material.dart';
import 'widgets.dart';
import 'coin_jar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Map<String, String>> jars = <Map<String, String>>[
    {
      'Name': 'HECS',
      'Balance': '10',
      'Goal': '100',
    },
    {
      'Name': 'Rego',
      'Balance': '50',
      'Goal': '100',
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
          padding: EdgeInsets.all(15),
          itemCount: jars.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Center(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text('${jars[index]['Name']}'),
                            Text(
                                '\$${jars[index]['Balance']} \/ ${jars[index]['Goal']}'),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        subtitle: Column(
                          children: [
                            LinearProgressIndicator(
                              value: (double.tryParse(jars[index]['Balance']) ??
                                      0) /
                                  (double.tryParse(jars[index]['Goal']) ?? 1),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CoinJarPage(
                          title: jars[index]['Name'],
                        )));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        )));
  }
}
