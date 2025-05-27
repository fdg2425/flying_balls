import 'dart:math';

import 'package:flutter/material.dart';

class Ball {
  static double speedFactor = 1;
  double left = 0;
  double top = 10;
  double speedX = 10;
  double speedY = 5;
  double diameter = 20;
  Color color = Colors.blue;

  Ball();

  Ball.random() {
    var random = Random();
    top = 50 + 200 * random.nextDouble();
    diameter = 2 + 40 * random.nextDouble();
    speedX = 0.5 + 4 * random.nextDouble();
    speedY = 0.5 + 4 * random.nextDouble();
    color = Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }

  void move() {
    left += speedX * speedFactor;
    top += speedY * speedFactor;
  }

  void bounce(double stackWidth, double stackHeight) {
    if (left < 0) {
      left = 0;
      speedX = -speedX;
    }
    if (left > stackWidth - diameter) {
      left = stackWidth - diameter;
      speedX = -speedX;
    }

    if (top < 0) {
      top = 0;
      speedY = -speedY;
    }
    if (top > stackHeight - diameter) {
      top = stackHeight - diameter;
      speedY = -speedY;
    }
  }
}
