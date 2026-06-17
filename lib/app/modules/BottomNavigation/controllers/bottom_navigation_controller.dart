import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt selectedIndex = 2.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
