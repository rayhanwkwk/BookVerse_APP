import 'package:get/get.dart';
import 'package:rayhan_bookverse/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
    );
  }
}
