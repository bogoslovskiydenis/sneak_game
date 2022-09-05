import 'dart:async';
import 'dart:math';

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

  //currentScore
  int currentScore = 0;

  //snake direction
  var currentDirection = snake_Direction.RIGHT;

  //startGame
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        //snake moving
        moveSnake();
        //snake is eating food
        eatFood();
        //check the game is over
        if (gameOver()) {
          timer.cancel();
          //display message
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Text('Your score is:' + currentScore.toString()),
              );
            }),
          );
        }
      });
    });
  }

  void eatFood() {
    if (sneaPosition.contains(foodPos)) {
      currentScore++;
    }
    //makiung sure the food is not whre the snake is
    while (sneaPosition.contains(foodPos)) {
      foodPos = Random().nextInt(totalNumberSqueares);
    }
  }

  //game over
  bool gameOver() {
    //game ia over when snake tun into inself
    List<int> bodySnake = sneaPosition.sublist(0, sneaPosition.length - 1);

    if (bodySnake.contains(sneaPosition.last)) {
      return true;
    }
    return false;
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
        }
        break;
      case snake_Direction.UP:
        {
          if (sneaPosition.last < rowSize) {
            sneaPosition.add(sneaPosition.last + rowSize + totalNumberSqueares);
          } else {
            sneaPosition.add(sneaPosition.last - rowSize);
          }
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
        }
        break;
      default:
    }
    //snake is eating food
    if (sneaPosition.last == foodPos) {
      eatFood();
    } else {
      //remove tail
      sneaPosition.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //scores
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Current Score',
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(currentScore.toString(),
                          style: TextStyle(fontSize: 40, color: Colors.white)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 5),
                    child: Text('hightscores....',
                        style: TextStyle(fontSize: 28, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
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
