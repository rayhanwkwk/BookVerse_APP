import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rayhan_bookverse/app/data/model/buku/response_detail_buku.dart';

import '../../../components/customTextFieldPeminjaman.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/peminjaman/response_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class DetailbookController extends GetxController with StateMixin{

  var dataDetailBook = Rxn<DataDetailBuku>();
  final id = Get.parameters['id'];

  var loading = false.obs;

  late String formattedToday;
  late String formattedTwoWeeksLater;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }

  // Data Peminjaman
  late String statusDataPeminjaman;

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku(id);

    // Get Tanggal hari ini
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 14));

    // Format tanggal menjadi string menggunakan intl package
    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Detail Buku
  Future<void> getDataDetailBuku(String? idBuku) async {
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailBuku}/$idBuku');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailBuku responseBuku = ResponseDetailBuku.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          dataDetailBook(responseBuku.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }


  // Koleksi Buku
  Future<void> addKoleksiBuku(BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().post(
        Endpoint.koleksiBuku,
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBuku = Get.parameters['judul'].toString();
        Fluttertoast.showToast(
          msg: "Buku $judulBuku berhasil disimpan di koleksi buku",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: const Color(0xFFFD5B35),
        );
        getDataDetailBuku(bukuID);
      } else {
        Fluttertoast.showToast(
          msg: "Buku gagal disimpan, silakan coba kembali",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Fluttertoast.showToast(
            msg: e.response?.data?['Message'] ?? "Terjadi kesalahan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xFFF5F5F5),
            textColor: Colors.black,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Terjadi kesalahan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
    } catch (e) {
      loading(false);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFF5F5F5),
        textColor: Colors.black,
      );
    }
  }

  deleteKoleksiBook(String id, BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().delete(
          '${Endpoint.deleteKoleksi}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Buku berhasil dihapus di koleksi buku",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: const Color(0xFFFD5B35),
        );
        getDataDetailBuku(id);
      } else {
        Fluttertoast.showToast(
          msg: "Buku gagal dihapus, silakan coba kembali",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Fluttertoast.showToast(
            msg: e.response?.data?['Message'] ?? "Terjadi kesalahan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xFFF5F5F5),
            textColor: Colors.black,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Terjadi kesalahan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFFF5F5F5),
          textColor: Colors.black,
        );
      }
    } catch (e) {
      loading(false);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFF5F5F5),
        textColor: Colors.black,
      );
    }
  }

  // Peminjaman
  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        ResponsePeminjaman responsePeminjaman = ResponsePeminjaman.fromJson(responsePostPeminjaman.data!);
        String judulBuku = Get.parameters['judul'].toString();
        String peminjamanID = responsePeminjaman.data!.peminjamanID.toString();

        getDataDetailBuku(bukuID);

        Get.snackbar("Borrow Book Success", "Buku $judulBuku berhasil dipinjam", backgroundColor: const Color(0xFFFD5B35),
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );

        Get.offAllNamed(Routes.BUKTIPEMINJAMAN, parameters: {
          'idPeminjaman': peminjamanID,
          'asalHalaman' : 'detailBuku',
        });
      } else {
        Get.snackbar(
            "Sorry",
            "Buku gagal dipinjam, silakan coba kembali",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.red, colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
    } catch (e) {
      loading(false);
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }

  Future<void> showConfirmPeminjaman(final onPressed, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Form Peminjaman Buku',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: ListBody(
                children: <Widget>[

                  Divider(
                    height: 2,
                    color: Colors.grey.withOpacity(0.20),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextFieldPeminjaman(
                    InitialValue: Get.parameters['judul'].toString(),
                    labelText: 'Judul Buku',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    preficIcon: const Icon(Icons.calendar_today),
                    InitialValue: formattedToday.toString(),
                    labelText: 'Tanggal Peminjaman',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    preficIcon: const Icon(Icons.calendar_today),
                    InitialValue: formattedTwoWeeksLater.toString(),
                    labelText: 'Deadline Pengembalian',
                    obsureText: false,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        value: isChecked.value,
                        onChanged: (value) {
                          toggleCheckBox();
                        },
                        activeColor: const Color(0xFFFD5B35),
                      )
                      ),
                      Expanded(
                        child: Text(
                          "Setuju dengan waktu peminjaman buku",
                          maxLines: 1,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            side: const BorderSide(
                              color: Color(0xFFFD5B35),
                              width: 1,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            Navigator.pop(Get.context!, 'OK');
                          },
                          child: Text(
                            'Batal',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFD5B35),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: const Color(0xFFFD5B35),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            if (!isChecked.value) {
                              return;
                            }
                            Navigator.pop(Get.context!, 'OK');
                            addPeminjamanBuku();
                          },
                          child: Text(
                            nameButton,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
