import 'package:db_oilab/ListeTests.dart';
import 'package:db_oilab/categoriesPage.dart';
import 'package:db_oilab/particuliers.dart';
import 'package:db_oilab/professionnels.dart';
import 'package:flutter/material.dart';

import 'AjoutTestPage.dart';
import 'LoginPage.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PageProfessionnels(),
    );
  }
}
