
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

class CurrencyInputCard extends StatelessWidget {
  final String label;
  final String flag;
  final String currencyCode;
  final String amount;

  const CurrencyInputCard({
    super.key,
    required this.label,
    required this.flag,
    required this.currencyCode,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              child: Text(
                flag,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              currencyCode,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
            const Spacer(),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: amount),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor:  Color(0xFFEFEFEF),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(width: 1, color:Color(0xFFEFEFEF) )
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}