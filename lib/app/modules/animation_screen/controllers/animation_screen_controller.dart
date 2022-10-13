import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationScreenController extends GetxController {
  RxList<MyClass> colorList = RxList<MyClass>([]);
  RxInt tickValue = 0.obs;
  RxBool isLastCompleted = false.obs;
  Timer? timer;
  @override
  void onInit() {
    List.generate(30, (index) {
      colorList.add(MyClass(color: Colors.transparent.obs));
    });
    print(colorList.length);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
    super.onInit();
  }

  startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      tickValue.value = timer.tick;

      if (tickValue.value > 0) {
        if (tickValue.value == 1) {
          colorList[0].color.value = Colors.red;
        }
        if (tickValue.value == 2) {
          colorList[0].color.value = Colors.green;
          colorList[1].color.value = Colors.red;
        }
        if (tickValue.value == 3) {
          colorList[0].color.value = Colors.amber;
          colorList[1].color.value = Colors.green;
          colorList[2].color.value = Colors.red;
        }
        if (isLastCompleted.isTrue && tickValue.value == 1) {
          colorList[colorList.length - 1].color.value = Colors.green;
          colorList[colorList.length - 2].color.value = Colors.amber;
          colorList[colorList.length - 3].color.value = Colors.transparent;
        } else if (isLastCompleted.isTrue && tickValue.value == 2) {
          colorList[colorList.length - 1].color.value = Colors.amber;
          colorList[colorList.length - 2].color.value = Colors.transparent;
        } else if (isLastCompleted.isTrue && tickValue.value == 3) {
          colorList[colorList.length - 1].color.value = Colors.transparent;
        }

        if (tickValue.value > 3) {
          colorList[tickValue.value - 4].color.value = Colors.transparent;
          colorList[tickValue.value - 3].color.value = Colors.amber;
          colorList[tickValue.value - 2].color.value = Colors.green;
          colorList[tickValue.value - 1].color.value = Colors.red;
        }
      }

      if (tickValue.value == colorList.length) {
        isLastCompleted.value = true;
        timer.cancel();
        startTimer();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer!.cancel();
    super.onClose();
  }
}

class MyClass {
  Rx<Color> color;
  MyClass({required this.color});
}
