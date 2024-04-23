class Endpoint {
  static const String baseUrlApi =
      "http://127.0.0.1:8000/api/users/";

  // Auth
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String getDataProfile = "${baseUrlApi}get-profile";
  static const String updateProfile = "${baseUrlApi}update/profile";

  // Book
  static const String buku = "${baseUrlApi}buku";
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String searchBook = "${baseUrlApi}buku/search";
  static const String bukuPopular = "${baseUrlApi}popular/buku";

  // Bookmarks
  static const String koleksiBuku = "${baseUrlApi}koleksi";
  static const String deleteKoleksi = "${baseUrlApi}";
  static const String historyPeminjaman = "${baseUrlApi}pinjam";

  // Ulasan Buku
  static const String ulasanBuku = "${baseUrlApi}ulasan";

  // Peminjamn
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";
}