import 'package:flutter/material.dart';

import 'package:mgmp/model_data.dart';
import 'package:provider/provider.dart';
import 'covert_string.dart';
import 'function.dart';

class DropDown extends StatelessWidget {
  final String formasi;
  DropDown(this.formasi);

  @override
  Widget build(BuildContext context) {
    //  Datas.voteKetua = Data.fromMap(
    //   {'Nama': formasi, 'Sma': 'Asal Sekolah', 'Voted': false, 'Kode': '0'});

    return Consumer<Fungsi>(builder: (context, s, c) {
      List<Data> dropDownsValue = [];
      if (formasi == 'Ketua') {
        dropDownsValue = s.dataK;
      }
      if (formasi == 'Sekretaris') {
        dropDownsValue = s.dataS;
      }
      if (formasi == 'Bendahara') {
        dropDownsValue = s.dataB;
      }

      asu() {
        if (formasi == 'Ketua') {
          return s.voteKetua;
        }
        if (formasi == 'Sekretaris') {
          return s.voteSekretaris;
        }
        if (formasi == 'Bendahara') {
          return s.voteBendahara;
        }
      }

      return Container(
        margin: EdgeInsets.only(bottom: 15,top: 15),decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
        child: Stack(
          children: [
            Card(
              shadowColor: Colors.blue.shade900,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    DropdownButton<Data>(
                      isExpanded: true,
                      alignment: Alignment.center,
                      value: asu(),
                      elevation: 16,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      style: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.blue,
                      // ),
                      onChanged: (Data? newValue) {
                        if (newValue!.nama != formasi) {
                          s.pickKeuta(newValue, formasi);
                        }
                      },
                      items:
                          dropDownsValue.map<DropdownMenuItem<Data>>((value) {
                        return DropdownMenuItem<Data>(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          value: value,
                          child: value.nama == formasi
                                  ? Text(
                                      'Pilih ${formasi}',
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                    ): Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(value.nama!.toTitleCase(),
                                            style: TextStyle(fontSize: 16)),
                                        Text(
                                          value.sma!.toTitleCase(),
                                          style: TextStyle(
                                              color: Colors.blue.shade600),
                                        ),
                                         Divider(
                                thickness: 2,
                                height: 5,
                                color: Colors.yellow.shade600,
                              )
                                      ],
                                    ),
                             
                          
                        );
                      }).toList(),
                    ),
                    //  Text(asu()!.sma!)
                  ],
                ),
              ),
            ),
            
          ],
        ),
      );
    });
  }
}
