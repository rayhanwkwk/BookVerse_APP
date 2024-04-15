import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:rayhan_bookverse/app/data/model/buku/response_book_new.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_popular_book.dart';
import '../../../data/provider/api_provider.dart';

class HomeController extends GetxController with StateMixin {

  // Get Book
  var newBooks = RxList<DataBookNew>();
  var popularBooks = RxList<DataPopularBook>();

  late AnimationController animationController;
  final textList = [
    'Buka buku, dan bukalah duniamu.',
    'Jangan lupa tersenyum hari ini!',
    'Baca buku adalah hobi yang luar biasa!',
    'Semangat dalam mengejar impian!',
  ].obs;

  final currentIndex = 0.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Timer untuk mengganti teks setiap 10 detik
    Timer.periodic(const Duration(seconds: 30), (timer) {
      currentIndex.value = (currentIndex.value + 1) % textList.length;
    });

    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    newBooks.clear();
    popularBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseNew = await ApiProvider.instance().get(Endpoint.bukuNew);
      final responsePopular = await ApiProvider.instance().get(Endpoint.bukuPopular);

      if (responseNew.statusCode == 200 && responsePopular.statusCode == 200) {
        final ResponseBookNew responseBukuNew = ResponseBookNew.fromJson(responseNew.data);
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBukuNew.data!.isEmpty && responseBukuPopular.data!.isEmpty) {
          newBooks.clear();
          popularBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          newBooks.assignAll(responseBukuNew.data!);
          popularBooks.assignAll(responseBukuPopular.data!);
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
}
