import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayhan_bookverse/app/components/custom_button.dart';
import 'package:rayhan_bookverse/app/routes/app_pages.dart';

import '../../../data/provider/storage_provider.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color primary = Color(0xFFFD5B35);
    const Color textColor = Color (0xFFFAFAFA);

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background/background_onboarding.png'),
            fit: BoxFit.cover,
          )
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                child: Text(
                  'BookVerse',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    color: textColor.withOpacity(0.60),
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pinjam Buku Kini Semakin Mudah',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.008,
                  ),

                  Text(
                    'Hanya dalam satu genggaman serta ujung jari kamu, kamu dapat membaca dan meminjam buku dengan mudah!',
                    maxLines: 3,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.055,
                  ),

                  CustomButton(
                      onPressed: (){
                        String? status = StorageProvider.read(StorageKey.status);

                        if (status == "logged") {
                          Get.offAllNamed(Routes.DASHBOARD);
                        }else{
                          Get.offAllNamed(Routes.LOGIN);
                        }
                      },
                      radius: 10.10,
                      buttonColor: primary,
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  textToRegister(),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget textToRegister() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              "Don't have an account?",
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),

          const SizedBox(
            width: 5,
          ),

          InkWell(
            onTap: ()=> Get.offAllNamed(Routes.REGISTER),
            child: Text('Sign Up',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFD5B35),
                )
            ),
          ),
        ],
      ),
    );
  }
}
