import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rayhan_bookverse/app/routes/app_pages.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color primary = Color (0xFF121212);
    const Color textColor = Color (0xFF818181);

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'assets/logo/logo.json',
                      repeat: false,
                      onLoaded: (composition) {
                        Future.delayed(const Duration(milliseconds: 6000), () {
                          Get.offAllNamed(Routes.ONBOARDING);
                        });
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'v1.0.0',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color:textColor,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
