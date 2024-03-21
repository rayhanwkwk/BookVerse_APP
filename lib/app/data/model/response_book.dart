/// Status : 200
/// Message : "Berhasil Menampilkan All Buku"
/// data : [{"KategoriBuku":"Novel Romance","Buku":[{"BukuID":1,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Wind Breaker.png","Judul":"Wind Breaker","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":2,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/OverLord.png","Judul":"OverLord","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":3,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Taiko.png","Judul":"Taiko","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4,"Total_ulasan":2,"JumlahRating":8,"JumlahPeminjam":0},{"BukuID":4,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Tensura.png","Judul":"Tensura","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4.5,"Total_ulasan":2,"JumlahRating":9,"JumlahPeminjam":0}]},{"KategoriBuku":"Novel Fantasy","Buku":[{"BukuID":1,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Wind Breaker.png","Judul":"Wind Breaker","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":2,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/OverLord.png","Judul":"OverLord","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":3,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Taiko.png","Judul":"Taiko","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4,"Total_ulasan":2,"JumlahRating":8,"JumlahPeminjam":0},{"BukuID":4,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Tensura.png","Judul":"Tensura","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4.5,"Total_ulasan":2,"JumlahRating":9,"JumlahPeminjam":0}]},{"KategoriBuku":"Novel Non Fiksi","Buku":[{"BukuID":5,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Ki Hajar Dewantara.png","Judul":"Ki Hajar Dewantara","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":0},{"BukuID":6,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/London Bridge.png","Judul":"London Bridge","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":7,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Revolusi France.png","Judul":"Revolusi France","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":0},{"BukuID":8,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Adolf Hitler.png","Judul":"Adolf Hitler","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":9,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Aspera Ad Astra.png","Judul":"Aspera Ad Astra","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4,"Total_ulasan":1,"JumlahRating":4,"JumlahPeminjam":0}]}]

class ResponseBook {
  ResponseBook({
      this.status, 
      this.message, 
      this.data,});

  ResponseBook.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataBook.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataBook>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// KategoriBuku : "Novel Romance"
/// Buku : [{"BukuID":1,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Wind Breaker.png","Judul":"Wind Breaker","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":2,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/OverLord.png","Judul":"OverLord","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0},{"BukuID":3,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Taiko.png","Judul":"Taiko","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4,"Total_ulasan":2,"JumlahRating":8,"JumlahPeminjam":0},{"BukuID":4,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Tensura.png","Judul":"Tensura","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4.5,"Total_ulasan":2,"JumlahRating":9,"JumlahPeminjam":0}]

class DataBook {
  DataBook({
      this.kategoriBuku, 
      this.buku,});

  DataBook.fromJson(dynamic json) {
    kategoriBuku = json['KategoriBuku'];
    if (json['Buku'] != null) {
      buku = [];
      json['Buku'].forEach((v) {
        buku?.add(Buku.fromJson(v));
      });
    }
  }
  String? kategoriBuku;
  List<Buku>? buku;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['KategoriBuku'] = kategoriBuku;
    if (buku != null) {
      map['Buku'] = buku?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BukuID : 1
/// CoverBuku : "http://192.168.43.21:8000/storage/images/coverbook/Wind Breaker.png"
/// Judul : "Wind Breaker"
/// Penulis : "Syoung Youn Kwon"
/// Penerbit : "Naver Webtoon"
/// TahunTerbit : "2013"
/// JumlahHalaman : "438"
/// Rating : 5
/// Total_ulasan : 1
/// JumlahRating : 5
/// JumlahPeminjam : 0

class Buku {
  Buku({
      this.bukuID, 
      this.coverBuku, 
      this.judul, 
      this.penulis, 
      this.penerbit, 
      this.tahunTerbit, 
      this.jumlahHalaman, 
      this.rating, 
      this.totalUlasan, 
      this.jumlahRating, 
      this.jumlahPeminjam,});

  Buku.fromJson(dynamic json) {
    bukuID = json['BukuID'];
    coverBuku = json['CoverBuku'];
    judul = json['Judul'];
    penulis = json['Penulis'];
    penerbit = json['Penerbit'];
    tahunTerbit = json['TahunTerbit'];
    jumlahHalaman = json['JumlahHalaman'];
    rating = json['Rating']?.toDouble();
    totalUlasan = json['Total_ulasan'];
    jumlahRating = json['JumlahRating'];
    jumlahPeminjam = json['JumlahPeminjam'];
  }
  int? bukuID;
  String? coverBuku;
  String? judul;
  String? penulis;
  String? penerbit;
  String? tahunTerbit;
  String? jumlahHalaman;
  double? rating;
  int? totalUlasan;
  int? jumlahRating;
  int? jumlahPeminjam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BukuID'] = bukuID;
    map['CoverBuku'] = coverBuku;
    map['Judul'] = judul;
    map['Penulis'] = penulis;
    map['Penerbit'] = penerbit;
    map['TahunTerbit'] = tahunTerbit;
    map['JumlahHalaman'] = jumlahHalaman;
    map['Rating'] = rating;
    map['Total_ulasan'] = totalUlasan;
    map['JumlahRating'] = jumlahRating;
    map['JumlahPeminjam'] = jumlahPeminjam;
    return map;
  }

}