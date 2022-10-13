import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Animation(),
    );
  }
}

class Animation extends StatefulWidget {
  const Animation({super.key});

  @override
  State<Animation> createState() => _AnimationState();
}

class _AnimationState extends State<Animation> {
  List left = [1, 2, 3, 4, 5, 6];
  int selected = -1;
  List<circalModel> colorsList = [];
  bool isLast = false;
  @override
  void initState() {
    List.generate(10, (index) {
      setState(() {
        colorsList.add(circalModel(color: Colors.transparent));
      });
    });
    // print(colorsList.length);
    timerData();
    super.initState();
  }

  timerData() {
    // selected = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      timer.tick;
      if (timer.tick < colorsList.length + 3) {
        selected++;
        print(timer.tick);
        print(isLast);
      } else {
        timer.cancel();
        selected = 0;
        timerData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 0, 236),
      body: Container(
        padding: EdgeInsets.only(top: 100, right: 50, left: 50),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: 25,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  if (index == colorsList.length - 1) {
                                    // print(index == colorsList.length - 1);
                                    setState(() {
                                      isLast = true;
                                    });
                                  } else {
                                    // print("object");
                                    setState(() {
                                      isLast = false;
                                    });
                                  }
                                });

                                return (selected == index)
                                    ? circal(color: Colors.red)
                                    : (selected == index + 1)
                                        ? circal(color: Colors.green)
                                        : (selected == index + 2)
                                            ? circal(color: Colors.blue)
                                            : circal(color: Colors.transparent);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 7,
                                );
                              },
                              itemCount: colorsList.length),
                        ),
                      ],
                    ),
                  ],
                ),
                // Spacer(),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: MediaQuery.of(context).size.height / 3,
                //       width: 25,
                //       child: ListView.separated(
                //           itemBuilder: (context, index) {
                //             return circal(color: Colors.transparent);
                //           },
                //           separatorBuilder: (context, index) {
                //             return SizedBox(
                //               height: 7,
                //             );
                //           },
                //           itemCount: left.length),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container circal({Color? color}) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
    ),
  );
}

class circalModel {
  Color? color;
  circalModel({this.color = Colors.transparent});
}
