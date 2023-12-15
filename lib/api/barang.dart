class Barang {
  final int idBarang;
  final String namaBarang;
  final int harga;

  Barang(
      {required this.idBarang, required this.namaBarang, required this.harga});

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      idBarang: json['id_barang'],
      namaBarang: json['nama_barang'],
      harga: json['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_barang': idBarang,
      'nama_barang': namaBarang,
      'harga': harga,
    };
  }
}
