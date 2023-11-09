import 'package:flutter/material.dart';

class InitScreen extends StatefulWidget {
  final PageController controller;
  InitScreen(this.controller);


  @override
  _InitScreenState createState() => _InitScreenState(controller);
}

class _InitScreenState extends State<InitScreen> {

  final PageController pageController;
  _InitScreenState(this.pageController);

  double displayHeight () => MediaQuery.of(context).size.height;
  double displayWidth () => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Column(
        children: <Widget>[
          Container(
            height: displayHeight() / 3,
            color: Colors.greenAccent[100],
          )
        ],
      )
    );
  }
}
