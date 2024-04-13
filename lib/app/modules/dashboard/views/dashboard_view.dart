import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rayhan_bookverse/app/components/customNavigationBar.dart';
import 'package:rayhan_bookverse/app/modules/book/views/book_view.dart';
import 'package:rayhan_bookverse/app/modules/bookmark/views/bookmark_view.dart';
import 'package:rayhan_bookverse/app/modules/historypeminjaman/views/historypeminjaman_view.dart';

import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                  child: IndexedStack(
                    index: controller.tabIndex,
                    children: const [
                      HomeView(),
                      BookView(),
                      BookmarkView(),
                      HistorypeminjamanView(),
                      ProfileView(),
                    ],
                  )
              ),
            ),

            bottomNavigationBar: CustomNavigationBar(
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
            ),
          );
        });
  }
}
