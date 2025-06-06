import 'dart:math';

import 'package:flutter/material.dart';

class Ball {
  static double speedFactor = 1;
  static double acceleration = 0;
  double left = 0;
  double top = 10;
  double speedX = 10;
  double speedY = 5;
  double diameter = 20;
  Color color = Colors.blue;
  Color color1 = Colors.yellow;

  Ball();

  Ball.random() {
    var random = Random();
    top = 50 + 200 * random.nextDouble();
    diameter = 2 + 40 * random.nextDouble();
    speedX = 0.5 + 4 * random.nextDouble();
    speedY = 0.5 + 4 * random.nextDouble();
    int r = random.nextInt(100);
    int g = random.nextInt(100);
    int b = random.nextInt(100);
    color = Color.fromARGB(255, r, g, b);
    color1 = Color.fromARGB(255, r + 156, g + 156, b + 156);
  }

  Gradient getGradient() {
    return LinearGradient(
        colors: [color1, color],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
  }

  void move() {
    left += speedX * speedFactor;
    speedY += acceleration;
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
