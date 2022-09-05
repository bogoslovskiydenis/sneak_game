import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sneak_game/widgets/foor_pixel.dart';
import 'package:sneak_game/widgets/pixel_border.dart';
import 'package:sneak_game/widgets/sneak_pixel.dart';

enum snake_Direction { UP, DOWN, LEFT, RIGHT }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //rowParametrs
  int rowSize = 10;
  int totalNumberSqueares = 100;

  //sneak position
  List<int> sneaPosition = [0, 1, 2];

  //food position
  int foodPos = 55;

  //snake direction
  var currentDirection = snake_Direction.RIGHT;

  //startGame
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        moveSnake();
      });
    });
  }

  void moveSnake() {
    switch (currentDirection) {
      case snake_Direction.RIGHT:
        {
          //if snake is at the right wall , need readjust
          if (sneaPosition.last % rowSize == 9) {
            sneaPosition.add(sneaPosition.last + 1 - rowSize);
          } else {
            sneaPosition.add(sneaPosition.last + 1);
          }
          //remove tail
          sneaPosition.removeAt(0);
        }
        break;
      case snake_Direction.LEFT:
        {
          //add a head
          if (sneaPosition.last % rowSize == 0) {
            sneaPosition.add(sneaPosition.last - 1 + rowSize);
          } else {
            sneaPosition.add(sneaPosition.last - 1);
          }
          //remove tail
          sneaPosition.removeAt(0);
        }
        break;
      case snake_Direction.UP:
        {
          if(sneaPosition.last <rowSize){
            sneaPosition.add(sneaPosition.last + rowSize + totalNumberSqueares);
          } else {
            sneaPosition.add(sneaPosition.last - rowSize);
          }
          //remove tail
          sneaPosition.removeAt(0);
        }
        break;
      case snake_Direction.DOWN:
        {
          //add a head
          if (sneaPosition.last + rowSize > totalNumberSqueares) {
            sneaPosition.add(sneaPosition.last + rowSize - totalNumberSqueares);
          } else {
            sneaPosition.add(sneaPosition.last + rowSize);
          }
          //remove tail
          sneaPosition.removeAt(0);
        }
        break;
      default:
    }
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
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 &&
                    currentDirection != snake_Direction.UP) {
                  currentDirection = snake_Direction.DOWN;
                  print('movie down');
                } else if (details.delta.dy < 0 &&
                    currentDirection != snake_Direction.DOWN) {
                  currentDirection = snake_Direction.UP;
                  print('move up');
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 &&
                    currentDirection != snake_Direction.RIGHT) {
                  currentDirection = snake_Direction.RIGHT;
                  print('movie right');
                } else if (details.delta.dx < 0 &&
                    currentDirection != snake_Direction.RIGHT) {
                  currentDirection = snake_Direction.LEFT;
                  print('movie left');
                }
              },
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
                  } else {
                    return const PixelBorder();
                  }
                },
              ),
            ),
          ),

          //play btn
          Expanded(
            child: Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  startGame();
                },
                child: const Text('PLAY'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
