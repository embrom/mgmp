
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mgmp/realtime_widet.dart';


class RealTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild realtime');
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('Respondend').get(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.blue.shade900,
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.docs.map(
                      (e) {
                      
                        return RealTimeWidet(e.data());
                      },
                    ).toList(),
                  ),
                ),
    );
  }
}
