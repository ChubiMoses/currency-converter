import 'package:ccapp/utils/utils.dart';
import 'package:ccapp/views/currency_converter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart' as provider;



void main() {
    WidgetsFlutterBinding.ensureInitialized();
      runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
          create: (_) => Utils(),
        ),

      ],
      child: MaterialApp(
        title: 'Currency Converter',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor:Color(0xFFF6F6F6),
      
        ),
        home: const CurrencyConverterView(),
      ),
    );
  }
}
