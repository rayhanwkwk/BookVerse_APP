import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color
    const Color primary = Color (0xFFFD5B35);
    const Color textColor = Color (0xFFFAFAFA);
    const Color colorButton = Color (0xFF121212);

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Size Text
    double text = 18.0;
    // double text3 = 14.0;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: colorButton,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
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
                  'Bookmarks',
                  style: GoogleFonts.plusJakartaSans(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: text,
                  ),
                ),
              ),

              Positioned(
                right: 5,
                child: RefreshIndicator(
                  onRefresh: () async {
                    // await controller.ge();
                  },
                  child: GestureDetector(
                    onTap: () async {
                      await controller.getData();
                    },
                    child: const Icon(
                      CupertinoIcons.refresh,
                      color: primary,
                      size: 25,
                    ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [

                SizedBox(
                  height: height * 0.025,
                ),

                sectionListBuku(width),

              ],
            ),
          ),
        ),
      )
    );
  }

  Widget sectionListBuku(double width) {
    const Color primary = Color(0xFFFD5B35);
    const Color textColor = Color (0xFF818181);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved Books",
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

        Obx((){
          if (controller.koleksiBook.isEmpty) {
            return Center(
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary,
                ),
                child: Center(
                  child: Text(
                    'Maaf Data Bookmarks Empty!',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            );
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                  controller.koleksiBook.length,
                      (index) {
                    var buku = controller.koleksiBook[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAILBOOK,
                          parameters: {
                            'id': (buku.bukuID ?? 0).toString(),
                            'judul': (buku.judul!).toString()
                          },
                        );
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
                              Padding(
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


                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        buku.judul!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF121212),
                                          fontSize: 20.0,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        buku.penulis!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                          fontSize: 12.0,
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
                                        maxLines: 3,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: Text(
                                          'Saved',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFFFD5B35),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
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
