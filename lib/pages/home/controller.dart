import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt count = 10.obs;

  onPageChange(int value) {
    print(value);
    if (value > count.value * 0.8) {
      count.value = count.value + 10;
    }
  }
}
