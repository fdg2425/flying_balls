// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

import 'ball.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FDG Flyung balls',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
            foregroundColor: Colors.white, // Text color
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium:
              TextStyle(color: Colors.blue), // default for medium body text
          titleLarge: TextStyle(color: Colors.blue), // for headlines, titles
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flying balls'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double marginRight = 0.0;
  double marginBottom = 0.0;
  bool expertMode = false;
  double yellowTop = 100;
  double yellowLeft = 300;
  double yellowWidth = 250;
  double yellowHeight = 100;
  double borderWidth = 10;
  double bottomRowHeight = 45;
  double speedX = 10;
  double speedY = 5;
  Timer? _timer;
  int timerCounter = 0;
  int buildCounter = 0;
  List<Ball> balls = [Ball()];

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
      setState(() {
        timerCounter++;
        // yellowLeft += speedX;
        // yellowTop += speedY;
        for (var ball in balls) {
          ball.move();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var stackWidth = screenWidth - 2 * borderWidth - marginRight;
    var stackHeight = screenHeight -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        2 * borderWidth -
        bottomRowHeight -
        marginBottom;

    if (expertMode) {
      stackHeight -= bottomRowHeight;
    }

// force the yellow container into the stack in every build
    // if (yellowLeft < 0) {
    //   yellowLeft = 0;
    //   speedX = -speedX;
    // }
    // if (yellowLeft > stackWidth - yellowWidth) {
    //   yellowLeft = stackWidth - yellowWidth;
    //   speedX = -speedX;
    // }

    // if (yellowTop < 0) {
    //   yellowTop = 0;
    //   speedY = -speedY;
    // }
    // if (yellowTop > stackHeight - yellowHeight) {
    //   yellowTop = stackHeight - yellowHeight;
    //   speedY = -speedY;
    // }
    for (var ball in balls) {
      ball.bounce(stackWidth, stackHeight);
    }
    buildCounter++;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        // do not show counters in the AppBar because they are hidden by the Debug banner
        //actions: [Text("$timerCounter, $buildCounter")]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  print("dx: ${details.delta.dx} dy: ${details.delta.dy}");
                  setState(() {
                    marginRight += -details.delta.dx;
                    marginBottom += -details.delta.dy;
                    if (marginRight < 0) {
                      marginRight = 0;
                    }
                    if (marginBottom < 0) {
                      marginBottom = 0;
                    }
                    if (marginRight > screenWidth * 0.8) {
                      marginRight = screenWidth * 0.8;
                    }
                    if (marginBottom > screenHeight * 0.7) {
                      marginBottom = screenHeight * 0.7;
                    }
                  });
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: marginRight, bottom: marginBottom),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.grey.shade500, width: borderWidth),
                  ),
                  child: Stack(children: [
                    for (var ball in balls)
                      Positioned(
                          top: ball.top,
                          // bottom: 300,
                          left: ball.left,
                          child: Container(
                            width: ball.diameter,
                            height: ball.diameter,
                            //color: Colors.green,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ball.color, // Color of the circle
                            ),
                          )),
                    // Positioned(
                    //     top: yellowTop,
                    //     left: yellowLeft,
                    //     child: GestureDetector(
                    //       onPanUpdate: (details) {
                    //         setState(() {
                    //           yellowLeft += details.delta.dx;
                    //           yellowTop += details.delta.dy;
                    //         });
                    //       },
                    //       child: Container(
                    //           width: yellowWidth,
                    //           height: yellowHeight,
                    //           color: Colors.yellow),
                    //     )),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Text("$timerCounter, $buildCounter"),
                    )
                  ]),
                ),
              ),
            ),
            if (expertMode)
              Container(
                height: bottomRowHeight,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Speed:",
                          style: Theme.of(context).textTheme.bodyMedium)
                    ]),
              ),
            Container(
              height: bottomRowHeight,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            expertMode = false;
                            balls.clear();
                            balls.add(Ball());
                          });
                        },
                        child: const Text("Reset")),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            balls.add(Ball.random());
                          });
                        },
                        child: const Text("Add 1 ball")),
                    if (!expertMode)
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              expertMode = true;
                            });
                          },
                          child: const Text("Expert mode")),
                    if (expertMode)
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Add 10 ball")),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
