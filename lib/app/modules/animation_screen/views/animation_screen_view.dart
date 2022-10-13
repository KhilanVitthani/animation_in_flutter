import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/animation_screen_controller.dart';

class AnimationScreenView extends GetWidget<AnimationScreenController> {
  const AnimationScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimationScreenController>(
        init: AnimationScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(
                    controller.colorList.length,
                    (index) =>
                        getContainer(index: index, controller: controller)),
              ),
            ),
          );
        });
  }

  getContainer(
      {required int index, required AnimationScreenController controller}) {
    return Obx(() {
      return Positioned(
        left: (index <= 14) ? 0 : null,
        right: (index > 14) ? 0 : null,
        bottom: (index <= 14) ? (200 + (index * 30)) : null,
        top: (index > 14) ? -100 + (index * 30) : null,
        child: Container(
          height: 25,
          width: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.colorList[index].color.value,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
          child: Text(
            controller.tickValue.value.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }
}
