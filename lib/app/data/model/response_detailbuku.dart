/// Status : 200
/// Message : "Berhasil Menampilkan Detail Buku"
/// data : {"Buku":{"BukuID":3,"Deskripsi":"Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0","CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Taiko.png","Judul":"Taiko","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4,"Total_ulasan":2,"JumlahRating":8,"JumlahPeminjam":0},"Kategori":["Novel Romance","Novel Fantasy"],"Ulasan":[{"UlasanID":3,"UserID":6,"BukuID":3,"Ulasan":"Bukunya keren, rekomendasi buat kalian pokoknya","Rating":3,"created_at":"2024-03-13T14:52:56.000000Z","updated_at":"2024-03-13T14:52:56.000000Z","users":{"id":6,"Username":"Shujinko App","Email":"shujinkoapp@smk.belajar.id","Password":"$2y$12$i6LEWWdtvPlTS35ErHFU6OWW9AuWyzrJ/te53ECS6RMaBwTCzfgRi","Level":"User","created_at":"2024-03-13T06:26:58.000000Z","updated_at":"2024-03-13T06:26:58.000000Z"}},{"UlasanID":4,"UserID":6,"BukuID":3,"Ulasan":"Bukunya keren, rekomendasi buat kalian pokoknya","Rating":5,"created_at":"2024-03-13T14:53:03.000000Z","updated_at":"2024-03-13T14:53:03.000000Z","users":{"id":6,"Username":"Shujinko App","Email":"shujinkoapp@smk.belajar.id","Password":"$2y$12$i6LEWWdtvPlTS35ErHFU6OWW9AuWyzrJ/te53ECS6RMaBwTCzfgRi","Level":"User","created_at":"2024-03-13T06:26:58.000000Z","updated_at":"2024-03-13T06:26:58.000000Z"}}]}

class ResponseDetailbuku {
  ResponseDetailbuku({
      this.status, 
      this.message, 
      this.data,});

  ResponseDetailbuku.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    data = json['data'] != null ? DataDetailBuku.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  DataDetailBuku? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// Buku : {"BukuID":3,"Deskripsi":"Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0","CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Taiko.png","Judul":"Taiko","Penulis":"Syoung Youn Kwon","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":4,"Total_ulasan":2,"JumlahRating":8,"JumlahPeminjam":0}
/// Kategori : ["Novel Romance","Novel Fantasy"]
/// Ulasan : [{"UlasanID":3,"UserID":6,"BukuID":3,"Ulasan":"Bukunya keren, rekomendasi buat kalian pokoknya","Rating":3,"created_at":"2024-03-13T14:52:56.000000Z","updated_at":"2024-03-13T14:52:56.000000Z","users":{"id":6,"Username":"Shujinko App","Email":"shujinkoapp@smk.belajar.id","Password":"$2y$12$i6LEWWdtvPlTS35ErHFU6OWW9AuWyzrJ/te53ECS6RMaBwTCzfgRi","Level":"User","created_at":"2024-03-13T06:26:58.000000Z","updated_at":"2024-03-13T06:26:58.000000Z"}},{"UlasanID":4,"UserID":6,"BukuID":3,"Ulasan":"Bukunya keren, rekomendasi buat kalian pokoknya","Rating":5,"created_at":"2024-03-13T14:53:03.000000Z","updated_at":"2024-03-13T14:53:03.000000Z","users":{"id":6,"Username":"Shujinko App","Email":"shujinkoapp@smk.belajar.id","Password":"$2y$12$i6LEWWdtvPlTS35ErHFU6OWW9AuWyzrJ/te53ECS6RMaBwTCzfgRi","Level":"User","created_at":"2024-03-13T06:26:58.000000Z","updated_at":"2024-03-13T06:26:58.000000Z"}}]

class DataDetailBuku {
  DataDetailBuku({
      this.buku, 
      this.kategori, 
      this.ulasan,});

  DataDetailBuku.fromJson(dynamic json) {
    buku = json['Buku'] != null ? Buku.fromJson(json['Buku']) : null;
    kategori = json['Kategori'] != null ? json['Kategori'].cast<String>() : [];
    if (json['Ulasan'] != null) {
      ulasan = [];
      json['Ulasan'].forEach((v) {
        ulasan?.add(Ulasan.fromJson(v));
      });
    }
  }
  Buku? buku;
  List<String>? kategori;
  List<Ulasan>? ulasan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (buku != null) {
      map['Buku'] = buku?.toJson();
    }
    map['Kategori'] = kategori;
    if (ulasan != null) {
      map['Ulasan'] = ulasan?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// UlasanID : 3
/// UserID : 6
/// BukuID : 3
/// Ulasan : "Bukunya keren, rekomendasi buat kalian pokoknya"
/// Rating : 3
/// created_at : "2024-03-13T14:52:56.000000Z"
/// updated_at : "2024-03-13T14:52:56.000000Z"
/// users : {"id":6,"Username":"Shujinko App","Email":"shujinkoapp@smk.belajar.id","Password":"$2y$12$i6LEWWdtvPlTS35ErHFU6OWW9AuWyzrJ/te53ECS6RMaBwTCzfgRi","Level":"User","created_at":"2024-03-13T06:26:58.000000Z","updated_at":"2024-03-13T06:26:58.000000Z"}

class Ulasan {
  Ulasan({
      this.ulasanID, 
      this.userID, 
      this.bukuID, 
      this.ulasan, 
      this.rating, 
      this.createdAt, 
      this.updatedAt, 
      this.users,});

  Ulasan.fromJson(dynamic json) {
    ulasanID = json['UlasanID'];
    userID = json['UserID'];
    bukuID = json['BukuID'];
    ulasan = json['Ulasan'];
    rating = json['Rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }
  int? ulasanID;
  int? userID;
  int? bukuID;
  String? ulasan;
  int? rating;
  String? createdAt;
  String? updatedAt;
  Users? users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UlasanID'] = ulasanID;
    map['UserID'] = userID;
    map['BukuID'] = bukuID;
    map['Ulasan'] = ulasan;
    map['Rating'] = rating;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (users != null) {
      map['users'] = users?.toJson();
    }
    return map;
  }

}

/// id : 6
/// Username : "Shujinko App"
/// Email : "shujinkoapp@smk.belajar.id"
/// Password : "$2y$12$i6LEWWdtvPlTS35ErHFU6OWW9AuWyzrJ/te53ECS6RMaBwTCzfgRi"
/// Level : "User"
/// created_at : "2024-03-13T06:26:58.000000Z"
/// updated_at : "2024-03-13T06:26:58.000000Z"

class Users {
  Users({
      this.id, 
      this.username, 
      this.email, 
      this.password, 
      this.level, 
      this.createdAt, 
      this.updatedAt,});

  Users.fromJson(dynamic json) {
    id = json['id'];
    username = json['Username'];
    email = json['Email'];
    password = json['Password'];
    level = json['Level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? username;
  String? email;
  String? password;
  String? level;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Username'] = username;
    map['Email'] = email;
    map['Password'] = password;
    map['Level'] = level;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// BukuID : 3
/// Deskripsi : "Wind Breaker menceritakan kisah tentang Jay Jay, seorang siswa SMA yang terkenal nakal dan suka berkelahi. Suatu hari, dia bertemu dengan trio pengendara sepeda motor bernama Wind Breaker, yang terdiri dari Bum, Min-soo, dan Yo-han. Jay Jay terkesan dengan keahlian mereka dan memutuskan untuk bergabung dengan klub mereka.0"
/// CoverBuku : "http://192.168.43.21:8000/storage/images/coverbook/Taiko.png"
/// Judul : "Taiko"
/// Penulis : "Syoung Youn Kwon"
/// Penerbit : "Naver Webtoon"
/// TahunTerbit : "2013"
/// JumlahHalaman : "438"
/// Rating : 4
/// Total_ulasan : 2
/// JumlahRating : 8
/// JumlahPeminjam : 0

class Buku {
  Buku({
      this.bukuID, 
      this.deskripsi, 
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
    deskripsi = json['Deskripsi'];
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
  String? deskripsi;
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
    map['Deskripsi'] = deskripsi;
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