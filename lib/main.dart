import 'package:flutter/material.dart';
import 'package:projeto_ebac_imc/views/imc_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const IMCPage(),
    );
  }
}
