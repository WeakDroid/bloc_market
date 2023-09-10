import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  void navigate(StatefulWidget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  void navigateBack() {
    Navigator.pop(context);
  }

  void navigateNewRoot(StatefulWidget destination) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return destination;
    }), (Route<dynamic> route) => false);
  }

  void navigateWithComeBackAction(
      StatefulWidget destination, VoidCallback onComeBack) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    ).then((value) {
      setState(() {
        onComeBack();
      });
    });
  }
}
