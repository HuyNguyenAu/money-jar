import 'package:flutter/material.dart';
import 'styles.dart';

class Widgets {
  static largeButton(String text, VoidCallback action, BuildContext context) {
    return _buttonBase(text, action, context, 0.8);
  }

  static smallButton(String text, VoidCallback action, BuildContext context) {
    return _buttonBase(text, action, context, 0.33);
  }

  static largeTextField(
      TextEditingController controller, BuildContext context) {
    return _textFieldBase(controller, context, 0.8);
  }

  static showMessageDialog(String title, String message, BuildContext context) {
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

  static showBottomModal(String title, String buttonText, VoidCallback action,
      TextEditingController controller, BuildContext context) {
    controller.text = '';
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(flex: 1),
                    Widgets.largeTextField(controller, context),
                    Spacer(flex: 1),
                    Widgets.smallButton(buttonText, action, context),
                    Spacer(flex: 1),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
          );
        });
  }

  static Container _textFieldBase(
      TextEditingController controller, BuildContext context, double scale) {
    return Container(
      child: TextField(
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: new BorderSide(color: Colors.blue)),
        ),
        keyboardType: TextInputType.number,
      ),
      width: MediaQuery.of(context).size.width * scale,
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }

  static ElevatedButton _buttonBase(
      String text, VoidCallback action, BuildContext context, double scale) {
    return ElevatedButton(
      child: SizedBox(
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Styles.buttonTextStyle(context),
          ),
        ),
        width: MediaQuery.of(context).size.width * scale,
        height: 55,
      ),
      onPressed: action,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    );
  }
}
