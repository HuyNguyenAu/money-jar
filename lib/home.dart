import 'package:flutter/material.dart';
import 'widgets.dart';
import 'coin_jar.dart';
import 'jar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final textFieldController = TextEditingController();
  List<Jar> jars = [];

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
                            Text(jars[index].name),
                            Text(
                                '\$${jars[index].balance} \/ ${jars[index].goal}'),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        subtitle: Column(
                          children: [
                            LinearProgressIndicator(
                                value: jars[index].balance /
                                    (jars[index].goal == 0
                                        ? 1
                                        : jars[index].goal)),
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
                          title: jars[index].name,
                        )));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Widgets.showTextBottomModal('Create New Jar', 'Create', () {
              setState(() {
                jars.add(Jar(textFieldController.text, 0, 0));
              });
            }, textFieldController, context);
          },
        ));
  }
}
