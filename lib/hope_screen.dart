import 'package:flutter/material.dart';
import 'package:sneak_game/widgets/pixel_border.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rowSize = 10;
  int totalNumberSqueares = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //scores
          Expanded(child: Container()),
          //game grid
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: totalNumberSqueares,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize),
              itemBuilder: (BuildContext context, int index) {
                return PixelBorder();
              },
            ),
          ),

          //play btn
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
