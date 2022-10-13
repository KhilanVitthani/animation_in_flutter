import 'package:get/get.dart';

import '../controllers/animation_screen_controller.dart';

class AnimationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimationScreenController>(
      () => AnimationScreenController(),
    );
  }
}
