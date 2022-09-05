import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FoodPosition extends StatelessWidget {
  const FoodPosition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
