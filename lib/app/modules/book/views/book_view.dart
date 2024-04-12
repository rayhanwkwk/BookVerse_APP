import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_textfield.dart';
import '../../../data/model/buku/response_search_buku.dart';
import '../../../routes/app_pages.dart';
import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
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
                  'Book',
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

      body: Container(
        width: width,
        height: height,
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.020,
                ),

                Text(
                  'Search',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  height: height * 0.010,
                ),

                CustomTextField(
                  controller: controller.searchController,
                  onChanged: (value){
                    controller.getDataBook();
                  },
                  hintText: 'Search Book Here',
                  obsureText: false,
                  preffixIcon: const Icon(Icons.search_rounded),
                  validator:  (value) {
                    if(value!.isEmpty){
                      return 'Masukan karakter searh buku';
                    }
                    return null;
                  },
                ),


                SizedBox(
                  height: height * 0.020,
                ),

                 sectionDataBook(),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget sectionDataBook(){
    const Color primary = Color(0xFFFD5B35);
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          controller.obx((state) {
            if (state == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            } else if (state.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              );
            }else{
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.length,
                itemBuilder: (context, index){
                  var kategori = state[index].kategoriBuku;
                  var bukuList = state[index].dataBuku;
                  if (bukuList == null || bukuList.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            kategori!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Buku ${controller.searchController.text} tidak ditemukan di kategori ini',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            kategori!,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bukuList?.length,
                            itemBuilder: (context, index) {
                              DataBuku buku = bukuList![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.DETAILBOOK,
                                      parameters: {
                                        'id': (buku.bukuID ?? 0).toString(),
                                        'judul': (buku.judul!).toString()
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.15),  // Warna garis
                                          width: 0.5,           // Lebar garis
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xFFFAFAFA)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 185,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: AspectRatio(
                                                aspectRatio: 4 / 5,
                                                child: Image.network(
                                                  buku.coverBuku.toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  buku.judul!,
                                                  style: GoogleFonts.plusJakartaSans(
                                                      fontWeight: FontWeight.w800,
                                                      color: Colors.black,
                                                      fontSize: 16.0
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),

                                                const SizedBox(height: 4),

                                                FittedBox(
                                                  child: Text(
                                                    buku.penulis!,
                                                    style: GoogleFonts.plusJakartaSans(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 10.0
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),

                                                const SizedBox(height: 4),

                                                FittedBox(
                                                  child: Text(
                                                    "${buku.jumlahHalaman!} Halaman",
                                                    style: GoogleFonts.plusJakartaSans(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 10.0
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),

                                                const SizedBox(height: 3),

                                                // Menampilkan rating di bawah teks penulis
                                                buku.rating != null && buku.rating! > 0
                                                    ? RatingBar.builder(
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
                                                    // Lakukan tindakan setelah pengguna mengupdate rating
                                                  },
                                                )
                                                    : RatingBar.builder(
                                                  initialRating: 5,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: Colors.grey,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    // Lakukan tindakan setelah pengguna mengupdate rating
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }
          )
        ],
      ),
    );
  }

  Widget sectionDataKosong(String text) {
    const Color background = Color(0xFF000000);
    return Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
