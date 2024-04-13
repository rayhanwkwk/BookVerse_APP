import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
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
                    'History Borrow Books',
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
                        await controller.getDataPeminjaman();
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
              "Borrowed Books",
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
          if (controller.historyPeminjaman.isEmpty) {
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
                      'Sorry data history borrow books empty!',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
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
                  controller.historyPeminjaman.length,
                      (index) {
                    var buku = controller.historyPeminjaman[index];
                    return InkWell(
                      onTap: () {
                        buku.status == 'Selesai' ? controller.kontenBeriUlasan(buku.bukuId.toString(), buku.judulBuku.toString()) :
                        Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
                          'idPeminjaman': buku.peminjamanID.toString(),
                          'asalHalaman' : 'historyPeminjaman',
                        });
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
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 2 / 2,
                                          child: Image.network(
                                            buku.coverBuku.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFFD5B35),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Text(
                                            buku.status!,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),


                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
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
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        buku.kodePeminjaman!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w900,
                                          color: primary,
                                          fontSize: 18.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'Tanggal Pinjam : ${buku.tanggalPinjam!}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                          fontSize: 12.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'Deadline Pinjam : ${buku.deadline!}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                          fontSize: 12.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        'Tanggal Kembali : ${buku.tanggalKembali!}',
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
