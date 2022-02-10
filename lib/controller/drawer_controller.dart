import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class DrawerControllers extends GetxController {
  AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();
  void handleMenuButtonPressed() {
    // advancedDrawerController.value = AdvancedDrawerValue.visible();
    advancedDrawerController.showDrawer();
    update();
  }
}
