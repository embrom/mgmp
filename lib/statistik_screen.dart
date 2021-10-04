import 'package:flutter/material.dart';
import 'package:mgmp/klasmen.dart';
import 'package:mgmp/realtime.dart';

class Statistik extends StatefulWidget {
  const Statistik({Key? key}) : super(key: key);

  @override
  _StatistikState createState() => _StatistikState();
}

class _StatistikState extends State<Statistik> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [KlasmenWidget(), Expanded(child: RealTime())],
    );
  }
}
