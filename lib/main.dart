import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mgmp/function.dart';
import 'package:mgmp/tab_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    ChangeNotifierProvider(
      builder: (context, child) => MyApp(),
      create: (ctx) => Fungsi(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
        fontFamily: 'Nunito',
           ),
      debugShowCheckedModeBanner: false,
      title: 'Pemilihan MGMP2',
      
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Fungsi>(context, listen: false).getData(),
        builder: (context, s) {
          return s.connectionState == ConnectionState.waiting
              ? Scaffold(
                  body: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 130,
                    ),
                  ),
                )
              : TabScreen();
        });
  }
}
