import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayhan_bookverse/app/data/model/response_book.dart';

import '../../../components/custom_textfield.dart';
import '../controllers/book_controller.dart';

class BookView extends GetView<BookController> {
  const BookView({Key? key}) : super(key: key);
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
                  hintText: 'Search Book Here',
                  obsureText: false,
                  preffixIcon: const Icon(Icons.search_rounded),
                  validator:  (value) {
                    if (value!.isEmpty) {
                      return 'Pleasse input karakter here';
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
                  var bukuList = state[index].buku;
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
                          height: 280, // Sesuaikan tinggi container sesuai kebutuhan Anda
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bukuList?.length,
                            itemBuilder: (context, index) {
                              Buku buku = bukuList![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Container(
                                  width: 135,
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
                                          width: 130, // Sesuaikan lebar gambar sesuai kebutuhan Anda
                                          height: 175, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
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
                                        FittedBox(
                                          child: Text(
                                            buku.judul!,
                                            style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                                fontSize: 16.0
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
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
                                            buku.penerbit!,
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 10.0
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        const SizedBox(height: 2),

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
                                            print(rating);
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
                                            print(rating);
                                            // Lakukan tindakan setelah pengguna mengupdate rating
                                          },
                                        ),
                                      ],
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
}
