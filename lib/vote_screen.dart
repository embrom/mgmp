import 'package:flutter/material.dart';
import 'package:mgmp/drowp_down.dart';
import 'package:mgmp/function.dart';
import 'package:provider/provider.dart';

class VoteScreen extends StatefulWidget {
  VoteScreen({Key? key}) : super(key: key);

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  TextEditingController _controller = TextEditingController();
  int? kode;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [ ElevatedButton(
                    style: ButtonStyle( shadowColor:   MaterialStateProperty.all(Colors.yellow.shade600),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade900)),
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      await Provider.of<Fungsi>(context, listen: false)
                          .submitVote(kode, context);
                      setState(() {
                        _controller.clear();
                        _loading = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        _loading ? 'Loading........' : 'Click Untuk Voting',
                        textAlign: TextAlign.center,
                      ),
                    )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    alignLabelWithHint: true,
                    labelText: 'Silahkan Masukan Kode........',
                    hintText: 'dd/mm/yyyy || cth: 25012005',
                    labelStyle: TextStyle()),
                onChanged: (s) {
                  setState(() {
                    if (s.isNotEmpty) {
                      kode = int.parse(s);
                    }
                  });
                },
              ),
            ),
          ],
        ),
        body: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          
          children: [
          
            DropDown('Ketua'),
            DropDown('Sekretaris'),
            DropDown('Bendahara'),
        
          ],
        ));
  }
}
