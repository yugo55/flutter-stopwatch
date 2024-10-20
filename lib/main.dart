import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Stopwatch',
      home: MyHomePage(title: 'Flutter Stopwatch'),
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
  String timer = "00:00:00";
  DateTime time = DateTime(2024);
  bool isStart = false;
  bool isStop = false;

  void start() {
    setState(() {
      isStart = true;
      isStop = false;
    });
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (isStart) {
        time = time.add(const Duration(seconds: 1));
        setState(() {
          timer =
              "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}:${time.second.toString().padLeft(2, "0")}";
        });
      } else if (isStop) {
        t.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timer,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purple.shade200)),
                  onPressed: isStart
                      ? null
                      : () {
                          start();
                        },
                  child: const Text("スタート"),
                ),
                const SizedBox(width: 15),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purple.shade200)),
                  onPressed: () {
                    setState(() {
                      isStart = false;
                      isStop = true;
                    });
                  },
                  child: const Text("ストップ"),
                ),
                const SizedBox(width: 15),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.purple.shade200)),
                  onPressed: () {
                    setState(() {
                      isStart = false;
                      isStop = true;
                      timer = "00:00:00";
                      time = DateTime(2024);
                    });
                  },
                  child: const Text("リセット"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
