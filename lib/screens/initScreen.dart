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
      color: Colors.teal[900],
      child: Column(
        children: <Widget>[
          Container(
            height: displayHeight() / 3,
            decoration: BoxDecoration(
              color: Colors.teal[800],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              )
            ),
            child: Icon(Icons.person, color: Colors.white, size:50,),

          )
        ],
      )
    );
  }
}
