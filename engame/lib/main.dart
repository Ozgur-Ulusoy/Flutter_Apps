import 'package:engame/provider/provider.dart';
import 'package:engame/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
        )
      ],
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ENGAME",
        //* Anasayfa
        home: EngameHomePage(),
      ),
    );
  }
}
