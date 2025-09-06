
import 'package:ccapp/utils/theme.dart';
import 'package:ccapp/widgets/currency_input_card.dart';
import 'package:ccapp/widgets/exchange_rate_widget.dart';
import 'package:ccapp/widgets/swap_widget.dart';
import 'package:flutter/material.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        //dismiss keyboard when user taps outside of the text field
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const SizedBox(height: 40),
                Center(
                  child: const Text(
                    'Currency Converter',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: const Text(
                    'Check live rates, set rate alerts, receive\nnotifications and more.',
                    style: TextStyle(
                      color:  AppTheme.greyColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                 Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                          CurrencyInputCard(
                            isBase: true,
                          ),
                          const SizedBox(height: 16),
                          SwapImageIconWidget(),
                          const SizedBox(height: 16),
                          CurrencyInputCard(
                            isBase: false,
                          ),
                    ],
                  ),
                ),
                ExchangeRateWidget()
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
