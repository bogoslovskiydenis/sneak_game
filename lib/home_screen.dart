import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sneak_game/widgets/foor_pixel.dart';
import 'package:sneak_game/widgets/pixel_border.dart';
import 'package:sneak_game/widgets/sneak_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int rowSize = 10;
  int totalNumberSqueares = 100;

  //sneak position
  List<int> sneaPosition = [0, 1, 2];

  //food position
  int foodPos = 55;

  //
  void startGame(){
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        //add head
        sneaPosition.add(sneaPosition.last +1);
        //remove tail
        sneaPosition.removeAt(0);
      });
    });
  }

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
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowSize),
              itemBuilder: (BuildContext context, int index) {
                if (sneaPosition.contains(index)) {
                  return const SneakPixel();
                } else if (foodPos == index) {
                  return const FoodPosition();
                }
                else {
                  return const PixelBorder();
                }
              },
            ),
          ),

          //play btn
          Expanded(
            child: Center(child: MaterialButton(
              color: Colors.blue, onPressed: () {
              startGame();
            },
              child: const Text('PLAY'),),),
          ),
        ],
      ),
    );
  }
}
