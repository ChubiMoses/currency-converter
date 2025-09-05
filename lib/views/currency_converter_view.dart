
import 'package:ccapp/widgets/currency_input_card.dart';
import 'package:ccapp/widgets/swap_widget.dart';
import 'package:flutter/material.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Currency Converter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Check live rates, set rate alerts, receive\nnotifications and more.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
               Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                        CurrencyInputCard(
                          label: 'Amount',
                          flag: 'SG',
                          currencyCode: 'SGD',
                          amount: '1000.00',
                        ),
                        const SizedBox(height: 16),
                        SwapWidget(),
                        const SizedBox(height: 16),
                        CurrencyInputCard(
                          label: 'Converted Amount',
                          flag: 'US',
                          currencyCode: 'USD',
                          amount: '736.70',
                        ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              const Text(
                'Indicative Exchange Rate',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '1 SGD = 0.7367 USD',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
