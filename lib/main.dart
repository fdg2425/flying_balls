// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                    border: Border.all(color: Colors.grey.shade500, width: 10),
                  ),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Reset")),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
