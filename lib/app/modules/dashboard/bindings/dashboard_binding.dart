import 'package:get/get.dart';
import 'package:rayhan_bookverse/app/modules/book/controllers/book_controller.dart';
import 'package:rayhan_bookverse/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:rayhan_bookverse/app/modules/historypeminjaman/controllers/historypeminjaman_controller.dart';
import 'package:rayhan_bookverse/app/modules/home/controllers/home_controller.dart';
import 'package:rayhan_bookverse/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<BookController>(
          () => BookController(),
    );
    Get.lazyPut<BookmarkController>(
          () => BookmarkController(),
    );
    Get.lazyPut<HistorypeminjamanController>(
          () => HistorypeminjamanController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
