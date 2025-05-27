class Ball {
  double left = 0;
  double top = 10;
  double speedX = 10;
  double speedY = 5;
  double diameter = 20;

  void move() {
    left += speedX;
    top += speedY;
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
