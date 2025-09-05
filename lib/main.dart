import 'package:ccapp/views/currency_converter_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor:Color(0xFFF6F6F6),

      ),
      home: const CurrencyConverterView(),
    );
  }
}
