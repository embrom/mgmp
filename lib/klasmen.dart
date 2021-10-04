import 'package:flutter/material.dart';
import 'package:mgmp/klasmen_model.dart';

import 'package:provider/provider.dart';
import 'covert_string.dart';
import 'function.dart';

class KlasmenWidget extends StatelessWidget {
  const KlasmenWidget({Key? key}) : super(key: key);
Widget _loading()=>Flexible(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only( bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: double.infinity,
              child: Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Text('',
            
              // maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
            Divider(
              height: 1,
              thickness: 3,
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              child: Text(
             '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  Widget formasi(Klasmen data, String formasi) {
    int? d;
    if (formasi == 'Ketua') {
      d = data.ketua;
    }
     if (formasi == 'Sekretaris') {
      d = data.sekretaris;
    }
     if (formasi == 'Bendahara') {
      d = data.bendahara;
    }
    return Flexible(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only( bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: double.infinity,
              child: Text(
                formasi,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Text(
            data.nama!.toTitleCase(),
              // maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
            Divider(
              height: 1,
              thickness: 3,
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              child: Text(
             d.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Fungsi>(builder: (context, d, c) {
      return Container(
        margin: EdgeInsets.only(top: 10,bottom: 0,left: 10,right: 10),
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Klasmen Terkini',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: (d.ketua == null ||
                        d.sekretasris == null ||
                        d.bendahara == null)
                    ? [
                        _loading(),_loading(),_loading()
                      ]
                    : [
                        formasi(d.ketua!, 'Ketua'),
                        formasi(d.sekretasris!, 'Sekretaris'),
                        formasi(d.bendahara!, 'Bendahara')
                      ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
