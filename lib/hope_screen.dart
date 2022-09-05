import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //scores
          Expanded(child: Container(color: Colors.red,)),
          //game grid
          Expanded(child: Container(color: Colors.black,)),

          //play btn
          Expanded(child: Container(color: Colors.blue,)),

        ],
      ),
    );
  }
}
