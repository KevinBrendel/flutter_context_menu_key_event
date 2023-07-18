import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const channel = MethodChannel("debug/channel");

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTapDown: (details) => print("tap down"),
                onTapUp: (details) => print("tap up"),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Do Nothing"),
                ),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTapDown: (details) async {
                  print("tap down");
                  print(await channel.invokeMethod(
                    "openMenu",
                    {
                      "x": details.globalPosition.dx,
                      "y": details.globalPosition.dy,
                    },
                  ));
                },
                onTapUp: (details) => print("tap up"),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Open Context Menu"),
                ),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTapDown: (details) {
                  print("tap down");
                  Future.delayed(const Duration(seconds: 1)).then((_) async {
                    print(await channel.invokeMethod(
                      "openMenu",
                      {
                        "x": details.globalPosition.dx,
                        "y": details.globalPosition.dy,
                      },
                    ));
                  });
                },
                onTapUp: (details) => print("tap up"),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Long Press to Open Context Menu"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
