import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayhan_bookverse/app/components/custom_ListAuthor.dart';
import 'package:rayhan_bookverse/app/data/provider/storage_provider.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color primary = Color (0xFFFD5B35);
    const Color textColor = Color (0xFFFAFAFA);
    const Color textDeskripsi = Color (0xFF818181);
    const Color colorButton = Color (0xFF121212);

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Size Text
    double h1 = 35.0;
    double h3 = 20.0;
    double text = 18.0;
    double text2 = 16.0;
    // double text3 = 14.0;

    // Get Data User
    String usernameUser = StorageProvider.read(StorageKey.username);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: colorButton,
    statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 51,
        backgroundColor: colorButton,
        elevation: 0,
        title: SizedBox(
          child: Stack(
            children: [
              Positioned(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    'assets/logo/logo_bookverse.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Center(
                child: Text(
                  'BookVerse',
                  style: GoogleFonts.plusJakartaSans(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: text,
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: width,
                color: colorButton,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.030),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: GoogleFonts.plusJakartaSans(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: h1,
                        ),
                      ),

                      Text(
                        usernameUser,
                        style: GoogleFonts.plusJakartaSans(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: h1,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Obx(() {
                        final currentIndex = controller.currentIndex.value;
                        final isPrimaryColor = currentIndex % 2 == 0;

                        return FittedBox(
                          child: Text(
                            controller.textList[currentIndex],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: text,
                              fontWeight: FontWeight.w500,
                              color: isPrimaryColor ? primary : textDeskripsi,
                            ),
                          ),
                        );
                      }
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.020,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: sectionImage()
                    ),

                    SizedBox(
                      height: height * 0.020,
                    ),

                    sectionBukuPopular(),

                    SizedBox(
                      height: height * 0.030,
                    ),

                    sectionListAuthor(),

                    SizedBox(
                      height: height * 0.040,
                    ),

                    sectionListBuku(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget sectionImage(){
    // Size
    double width = MediaQuery.of(Get.context!).size.width;
    return Container(
      width: width,
      height: 115,
      decoration: const BoxDecoration(
        image:  DecorationImage(
          image: AssetImage(
            'assets/background/background_home.png',
          ),
          fit: BoxFit.cover
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temukan Ribuan Buku',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 26.0
                    ),
                  ),
                  Text(
                    'Dengan sekali klik',
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14.0
                    ),
                  )
                ],
              ),
            ),

            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.navigate_next_rounded,
                color: Colors.black,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sectionBukuPopular(){
    const Color primary = Color(0xFFFD5B35);
    const Color textColor = Color (0xFF818181);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Most Popular",
                  maxLines: 1,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),

               const SizedBox(
                 height: 3,
               ),

               Container(
                 width: 25,
                 height: 1,
                 decoration: BoxDecoration(
                   color: Colors.black,
                   borderRadius: BorderRadius.circular(100),
                 ),
               )
              ],
            ),

            InkWell(
              onTap: (){

              },
              child: Text(
                "View All",
                maxLines: 1,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  color: primary,
                  fontSize: 14.0,
                ),
              ),
            ),

          ],
        ),

        const SizedBox(
          height: 20,
        ),

        GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.popularBooks.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            } else if (controller.popularBooks.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            } else {
              return SizedBox(
                height: 240,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.popularBooks.value!.length,
                    itemBuilder: (context, index) {
                      var buku = controller.popularBooks.value![index];
                      return InkWell(
                        onTap: () {
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 175,
                                decoration : BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.20), // Warna garis tepi
                                    width: 1, // Lebar garis tepi
                                  ),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: AspectRatio(
                                    aspectRatio: 4 / 5,
                                    child: Image.network(
                                      buku.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              FittedBox(
                                child: Text(
                                  buku.judul!,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 14.0
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              FittedBox(
                                child: Text(
                                  buku.penulis!,
                                  maxLines: 1,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                      fontSize: 10.0
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              const SizedBox(height: 5),

                              RatingBar.builder(
                                initialRating: buku.rating!,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: primary,
                                ),
                                onRatingUpdate: (rating) {

                                }
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget sectionListAuthor(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Best Author this Month",
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),

            const SizedBox(
              height: 3,
            ),

            Container(
              width: 25,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            )
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        CustomListAuthor(context: Get.context!),
      ],
    );
  }

  Widget sectionListBuku() {
    const Color primary = Color(0xFFFD5B35);
    const Color textColor = Color (0xFF818181);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommended",
                  maxLines: 1,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Container(
                  width: 25,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              ],
            ),

            InkWell(
              onTap: (){

              },
              child: Text(
                "View All",
                maxLines: 1,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  color: primary,
                  fontSize: 14.0,
                ),
              ),
            ),

          ],
        ),

        const SizedBox(
          height: 20,
        ),

        GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.newBooks.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            } else if (controller.newBooks.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(
                    controller.newBooks.value!.length,
                        (index) {
                      var buku = controller.newBooks.value![index];
                      return InkWell(
                        onTap: () {
                          // Implementasi logika ketika buku ditekan
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: MediaQuery.of(Get.context!).size.width,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            height: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Gambar di sebelah kiri
                                Flexible(
                                  flex:2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 150,
                                      decoration : BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: const Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      // Lebar gambar 40% dari layar
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 2 / 2,
                                          child: Image.network(
                                            buku.coverBuku.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          buku.judulBuku!,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF121212),
                                            fontSize: 18.0,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          buku.deskripsi!,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Penulis : ${buku.penulisBuku!}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );

            }
          },
        ),
      ],
    );
  }
}
