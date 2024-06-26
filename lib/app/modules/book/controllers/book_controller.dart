import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_search_buku.dart';
import '../../../data/provider/api_provider.dart';

class BookController extends GetxController  with StateMixin<List<DataSearch>>{

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Buku
  Future<void> getDataBook() async{
    change(null, status: RxStatus.loading());
    try {
      final keyword = searchController.text.toString();
      final response;

      if (keyword == ''){
        response = await ApiProvider.instance().get('${Endpoint.searchBook}/null');
      }else{
        response = await ApiProvider.instance().get('${Endpoint.searchBook}/$keyword');
      }

      if (response.statusCode == 200) {
        final ResponseSearchBuku responseBuku = ResponseSearchBuku.fromJson(response.data);
        if(responseBuku.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responseBuku.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
