import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color
    const Color primary = Color (0xFFFD5B35);
    const Color textColor = Color (0xFF818181);
    const Color textField = Color (0xFF000000);
    const Color colorButton = Color (0xFF121212);

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Size Text
    double h1 = 40.0;
    double text = 18.0;
    double text3 = 14.0;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: h1,
                        color: textField
                    ),
                  ),

                  SizedBox(
                    height: height * 0.005,
                  ),

                  Text(
                    'Please sign-up to continue',
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: text,
                        color: textColor
                    ),
                  ),

                  SizedBox(
                    height: height * 0.035,
                  ),

                  Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Username',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: text3,
                            color: textField,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        CustomTextField(
                          controller: controller.usernameController,
                          hintText: 'Book Verse',
                          onChanged: (value){

                          },
                          obsureText: false,
                          preffixIcon: const Icon(Icons.email),
                          validator:  (value) {
                            if (value!.isEmpty) {
                              return 'Pleasse input username';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        Text(
                          'Email Address',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: text3,
                            color: textField,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        CustomTextField(
                          controller: controller.emailController,
                          hintText: 'bookverse@smk.belajar.id',
                          onChanged: (value){

                          },
                          obsureText: false,
                          preffixIcon: const Icon(Icons.email),
                          validator:  (value) {
                            if (value!.isEmpty) {
                              return 'Pleasse input email address';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Email address tidak sesuai';
                            } else if (!value.endsWith('@smk.belajar.id')) {
                              return 'Email harus @smk.belajar.id';
                            }

                            return null;
                          },
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        Text(
                          'Password',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: text3,
                            color: textField,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        Obx(() =>
                            CustomTextField(
                              controller: controller.passwordController,
                              hintText: 'bookverse@smk.belajar.id',
                              onChanged: (value){

                              },
                              obsureText: controller.isPasswordHidden.value,
                              preffixIcon: const Icon(Icons.lock),
                              suffixIcon: InkWell(
                                child: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  color: colorButton,
                                ),
                                onTap: () {
                                  controller.isPasswordHidden.value =
                                  !controller.isPasswordHidden.value;
                                },
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please input password';
                                } else if (value.length < 8){
                                  return 'Panjang password harus lebih dari 8';
                                }
                                // Validasi setidaknya satu huruf besar
                                else if (!value.contains(RegExp(r'[A-Z]'))) {
                                  return 'Password harus mengandung satu huruf besar';
                                }
                                // Validasi setidaknya satu karakter khusus
                                else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                  return 'Password harus mengandung satu karakter khusus';
                                }
                                // Validasi setidaknya satu angka
                                else if (!value.contains(RegExp(r'[0-9]'))) {
                                  return 'Password harus mengandung minimal 1 angka';
                                }
                                return null;
                              },
                            ),
                        ),

                        SizedBox(
                          height: height * 0.050,
                        ),

                        CustomButton(
                            onPressed: ()=>controller.registerPost(),
                            radius: 10.10,
                            buttonColor: colorButton,
                            child: Obx(() => controller.loadingregister.value?
                            const CircularProgressIndicator(
                              color: primary,
                            ): Text(
                              'Sign In',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ))
                        ),

                        SizedBox(
                          height: height * 0.030,
                        ),

                        textToRegister()
                      ],
                    ),
                  )
                ],
              ),
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
              "You have an account?",
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),

          const SizedBox(
            width: 5,
          ),

          InkWell(
            onTap: ()=> Get.offAllNamed(Routes.LOGIN),
            child: Text('Sign In',
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
