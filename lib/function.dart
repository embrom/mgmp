import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:mgmp/klasmen_model.dart';
import 'package:mgmp/model_data.dart';

class Fungsi extends ChangeNotifier {
  List<Data> dataK = [];
  List<Data> dataS = [];
  List<Data> dataB = [];
  List<Data> firebaseData = [];
  bool boolean = false;
  Data voteKetua = Data.fromMap(
      {'Nama': 'Ketua', 'Sma': 'Asal Sekolah', 'Voted': false, 'Kode': '0'});
  Data voteSekretaris = Data.fromMap({
    'Nama': 'Sekretaris',
    'Sma': 'Asal Sekolah',
    'Voted': false,
    'Kode': '0'
  });
  Data voteBendahara = Data.fromMap({
    'Nama': 'Bendahara',
    'Sma': 'Asal Sekolah',
    'Voted': false,
    'Kode': '0'
  });
  Klasmen? ketua;
  Klasmen? sekretasris;
  Klasmen? bendahara;
  List<Klasmen> klasmens = [];
  getData() async {
    print('getData');
    QuerySnapshot<Map<String, dynamic>> realData =
        await FirebaseFirestore.instance.collection('Respondend').get();
    if (klasmens.isEmpty) {
      for (var e in realData.docs) {
        klasmens.add(Klasmen.fromMap(e.data()));
        dataK.add(Data.fromMap(
          e.data(),
        ));
        dataS.add(Data.fromMap(
          e.data(),
        ));
        firebaseData.add(Data.fromMap(
          e.data(),
        ));
        dataB.add(Data.fromMap(
          e.data(),
        ));
      }
    }

    if (!dataK.contains(voteKetua)) {
      dataK.insert(0, voteKetua);
      dataS.insert(0, voteSekretaris);
      dataB.insert(0, voteBendahara);
    }
  }

  submitVote(int? kode, BuildContext context) async {
    if (voteKetua.nama == 'Ketua' ||
        voteSekretaris.nama == 'Sekretaris' ||
        voteBendahara.nama == 'Bendahara' ||
        voteKetua.nama == voteSekretaris.nama ||
        voteSekretaris.nama == voteBendahara.nama ||
        voteKetua.nama == voteBendahara.nama) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Silahkan Pilih Calon dengan Benar'),
            ],
          )));
      return;
    }
    if (firebaseData.every((element) => element.kode != kode || kode == null)) {
      print('ckeko kode');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kode Salah'),
            ],
          )));
      return;
    }
    Data user = firebaseData.firstWhere((element) => element.kode == kode);
    if (user.voted == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Anda Sudah Memvote'),
            ],
          )));
      return;
    }

    await FirebaseFirestore.instance
        .collection('Respondend')
        .doc(voteKetua.nama)
        .collection('K')
        .doc()
        .set({'Vote': user.nama});

    await FirebaseFirestore.instance
        .collection('Respondend')
        .doc(voteSekretaris.nama)
        .collection('S')
        .doc()
        .set({'Vote': user.nama});
    await FirebaseFirestore.instance
        .collection('Respondend')
        .doc(voteBendahara.nama)
        .collection('B')
        .doc()
        .set({'Vote': user.nama});
    await FirebaseFirestore.instance
        .collection('Respondend')
        .doc(user.nama)
        .update({'Voted': true});
    print(user.voted);
    user.voted = true;
    firebaseData[firebaseData.indexWhere((element) => element.kode == kode)] =
        user;
    print(
        firebaseData[firebaseData.indexWhere((element) => element.kode == kode)]
            .voted);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Vote Telah Terkirim'),
          ],
        )));

    reset();
  }

  void pickKeuta(Data d, String formasi) {
    if (formasi == 'Ketua') {
      voteKetua = d;
      notifyListeners();
    }
    if (formasi == 'Sekretaris') {
      voteSekretaris = d;
      notifyListeners();
    }
    if (formasi == 'Bendahara') {
      voteBendahara = d;
      notifyListeners();
    }
  }

  void reset() {
    voteKetua = dataK.firstWhere((element) => element.nama == 'Ketua');
    voteSekretaris =
        dataS.firstWhere((element) => element.nama == 'Sekretaris');
    voteBendahara = dataB.firstWhere((element) => element.nama == 'Bendahara');

    notifyListeners();
  }

  void klasmenKeuta(String nama, int vote) {
    if (vote > 0) {
      int temp = klasmens.indexWhere((element) => element.nama == nama);
      klasmens[temp].ketua = vote;
      klasmens.sort((a, b) => a.ketua!.compareTo(b.ketua!));
      ketua = klasmens.last;

      notifyListeners();
    }
  }

  void klasmenSekretasi(String nama, int vote) {
    if (vote > 0) {
      int temp = klasmens.indexWhere((element) => element.nama == nama);
      klasmens[temp].sekretaris = vote;
      klasmens.sort((a, b) => a.sekretaris!.compareTo(b.sekretaris!));
      sekretasris = klasmens.last;

      notifyListeners();
    }
  }

  void klasmenBendahara(String nama, int vote) {
    if (vote > 0) {
      int temp = klasmens.indexWhere((element) => element.nama == nama);
      klasmens[temp].bendahara = vote;
      klasmens.sort((a, b) => a.bendahara!.compareTo(b.bendahara!));
      bendahara = klasmens.last;

      notifyListeners();
    }
  }
  // Future getdata() async {
  //   print('hayoo');
  //   for (var element in DATA_RESPONDEND) {
  //     await FirebaseFirestore.instance
  //         .collection('Respondend')
  //         .doc(element['Nama'])
  //         .set({...element, 'Voted': false});
  //     await FirebaseFirestore.instance
  //         .collection('Respondend')
  //         .doc(element['Nama']).collection('K').doc()
  //         .set({'Pemilih': element['Nama']});
  //         await FirebaseFirestore.instance
  //         .collection('Respondend')
  //         .doc(element['Nama']).collection('B').doc()
  //         .set({'Pemilih': element['Nama']});
  //         await FirebaseFirestore.instance
  //         .collection('Respondend')
  //         .doc(element['Nama']).collection('S').doc()
  //         .set({'Pemilih': element['Nama']});
  //   }
  // }
}
