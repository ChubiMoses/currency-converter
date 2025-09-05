import 'package:ccapp/utils/utils_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangeRateWidget extends StatefulWidget {
  const ExchangeRateWidget({super.key});

  @override
  State<ExchangeRateWidget> createState() => _ExchangeRateWidgetState();
}

class _ExchangeRateWidgetState extends State<ExchangeRateWidget> {
  @override
  Widget build(BuildContext context) {
        final utilsProvider = context.watch<UtilsProvider>();

   return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
              const Text(
                'Indicative Exchange Rate',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
                Text(
             utilsProvider.isReverse? '1  ${utilsProvider.targetCode} = ${utilsProvider.converstionRate}  ${utilsProvider.baseCode}' : 
              '1  ${utilsProvider.baseCode} = ${utilsProvider.converstionRate}  ${utilsProvider.targetCode}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
        ],
      );
  }
}