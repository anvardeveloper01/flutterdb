import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:workwithdb/view/homepage.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  );
}
