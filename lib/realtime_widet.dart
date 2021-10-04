import 'dart:math';
import 'covert_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mgmp/function.dart';
import 'package:provider/provider.dart';

class RealTimeWidet extends StatefulWidget {
  final Map<String, dynamic> nama;
  const RealTimeWidet(this.nama, {Key? key}) : super(key: key);

  @override
  _RealTimeWidetState createState() => _RealTimeWidetState();
}

class _RealTimeWidetState extends State<RealTimeWidet>
    with AutomaticKeepAliveClientMixin {
  final _random = Random();
  @override
  bool get wantKeepAlive => true;
  Widget formasi(String nama, String formasi, String path) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Respondend')
            .doc(nama)
            .collection(formasi)
            .snapshots(),
        builder: (context, ketua) {
          if (ketua.connectionState == ConnectionState.waiting) {
            return Text('$path: ---');
          }

          if (formasi == 'K') {
            Future.delayed(
                const Duration(milliseconds: 50),
                () => Provider.of<Fungsi>(context, listen: false)
                    .klasmenKeuta(nama, ketua.data!.docs.length - 1));
          }
          if (formasi == 'S') {
            Future.delayed(
                const Duration(milliseconds: 50),
                () => Provider.of<Fungsi>(context, listen: false)
                    .klasmenSekretasi(nama, ketua.data!.docs.length - 1));
          }
          if (formasi == 'B') {
            Future.delayed(
                const Duration(milliseconds: 50),
                () => Provider.of<Fungsi>(context, listen: false)
                    .klasmenBendahara(nama, ketua.data!.docs.length - 1));
          }
          return Row(
            children: [
              Text('$path:'),
              Text(
                (ketua.data!.docs.length - 1).toString(),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
   
    super.build(context);
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[_random.nextInt(Colors.primaries.length)]
                  [_random.nextInt(9) * 100],
          child: Text(
            widget.nama['Nama'][0],
            overflow: TextOverflow.fade,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text((widget.nama['Nama'] as String).toTitleCase() ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((widget.nama['Sma'] as String).toTitleCase(),
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formasi(widget.nama['Nama'], 'K', 'Ketua'),
                formasi(widget.nama['Nama'], 'S', 'Sekretaris'),
                formasi(
                  widget.nama['Nama'],
                  'B',
                  'Bendahara',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
