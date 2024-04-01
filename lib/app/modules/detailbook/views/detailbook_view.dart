import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/response_detail_book.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
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
        toolbarHeight: 55,
        backgroundColor: colorButton,
        elevation: 0,
        title: SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  Get.parameters['judul'].toString(),
                  style: GoogleFonts.plusJakartaSans(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: text,
                  ),
                ),
              ),

              RefreshIndicator(
                onRefresh: () async {
                  // await controller.ge();
                },
                child: GestureDetector(
                  onTap: () async {
                    await controller.getDataDetailBuku(Get.parameters['id']);
                  },
                  child: const Icon(
                    CupertinoIcons.refresh,
                    color: primary,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        iconTheme:  const IconThemeData(color: Colors.white),
      ),
        body: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              ListView(
                children: [
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: sectionDetailBook()
                  ),
                  const SizedBox(height: 50),
                ],
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color(0xFFF5F5F5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: SizedBox(
                        height: 50.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFD5B35),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        100))),
                            onPressed: () {

                            },
                            child: Text(
                              "Pinjam Buku",
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget sectionDetailBook(){
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    final bodyHeight = height - 50;
    return Obx((){
      if (controller.dataDetailBook.value == null) {
        return SizedBox(
          width: width,
          height: bodyHeight,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFD5B35)),
            ),
          ),
        );
      } else {
        var dataBuku = controller.dataDetailBook.value?.buku;
        var dataUlasan = controller.dataDetailBook.value?.ulasan;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: height * 0.015,
            ),

            SizedBox(
              width: width,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 225,
                      width: width * 0.40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          dataBuku!.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: width * 0.035,
                    ),

                    Expanded(
                      child: SizedBox(
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataBuku.judul!,
                                      maxLines: 2,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 30.0,
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                    ),

                                    SizedBox(
                                      height: height * 0.010,
                                    ),

                                    Text(
                                      dataBuku.deskripsi!,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    SizedBox(
                                      height: height * 0.010,
                                    ),

                                    RatingBarIndicator(
                                      rating: dataBuku.rating!,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          backgroundColor: const Color(0xFFFD5B35),
                                        ),
                                        onPressed: (){
                                          if (dataBuku.status == 'Tersimpan'){
                                            controller.deleteKoleksiBook(dataBuku.bukuID.toString(), Get.context!);
                                          }else{
                                            controller.addKoleksiBuku(Get.context!);
                                          }
                                        },
                                        child: Text(
                                          dataBuku.status == "Tersimpan" ? 'Saved' : 'Add Bookmark',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Icon(
                                      dataBuku.status == 'Tersimpan' ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark,
                                      color: Colors.black,
                                      size: 35,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: height * 0.020,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pengarang: ${dataBuku.penulis} | Penerbit: ${dataBuku.penerbit} | Tahun Terbit: ${dataBuku.tahunTerbit}'
                    ' | Jumlah Halaman: ${dataBuku.jumlahHalaman.toString()} | Jumlah Peminjam: ${dataBuku.jumlahPeminjam.toString()}',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                  height: 1.6,
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
                maxLines: 5,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Tentang buku ini',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                  height: 1.6,
                  fontSize: 20,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                dataBuku.deskripsi!.toString(),
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                  height: 1.6,
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            SizedBox(
              height: height * 0.015,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Ulasan Buku',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        height: 1.6,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: buildUlasanList(dataUlasan),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * 0.020,
            ),
          ],
        );
      }
    }
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF424242).withOpacity(0.10),
                  width: 0.5,
                )
            ),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/avatar/Avatar3.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.025,
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ulasan.users?.username ?? '',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  // Menampilkan rating di bawah teks penulis
                                  SizedBox(
                                    child: RatingBarIndicator(
                                      direction: Axis.horizontal,
                                      rating: ulasan.rating!.toDouble(),
                                      itemCount: 5,
                                      itemSize: 14,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Color(0xFFFD5B35),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    ulasan.ulasan!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFB9B6B6),
                        fontSize: 13),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.01),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
