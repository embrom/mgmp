class Klasmen {
  Klasmen(this.nama, this.kode, this.sma, this.ketua, this.sekretaris,
      this.bendahara);
  String? nama;
  int? wa;
  String? sma;
  int? ketua;
  int? sekretaris;
  int? bendahara;
  int? kode;

  factory Klasmen.fromMap(
    Map<String, dynamic> snippet,
  ) {
    return Klasmen(snippet['Nama'], int.parse(snippet['Kode']), snippet['Sma'],
        snippet['K'] ?? 0, snippet['S'] ?? 0, snippet['B'] ?? 0);
  }
}
