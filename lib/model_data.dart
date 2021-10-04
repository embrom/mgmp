
class Data {
  Data(this.nama, this.kode, this.sma, this.voted);
  String? nama;
  int? wa;
  String? sma;
  bool voted = false;
  int? kode;

  factory Data.fromMap(
    Map<String, dynamic> snippet,
  ) {
   

    return Data(snippet['Nama'], int.parse(snippet['Kode']),
       snippet['Sma'], snippet['Voted']);
  }
}
