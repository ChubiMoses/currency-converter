import 'package:ccapp/data/view_model/currency_converter_states.dart';
import 'package:ccapp/data/view_model/currency_converter_view_model.dart';
import 'package:ccapp/providers/currency_providers.dart';
import 'package:ccapp/utils/theme.dart';
import 'package:ccapp/widgets/notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExchangeRateWidget extends ConsumerWidget {
  const ExchangeRateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyState = ref.watch(currencyStateProvider);
    final viewModel = ref.watch(currencyConverterVM);

    if (viewModel is CurrencyConverterError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNotification(context, message: viewModel.error);
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Indicative Exchange Rate',
          style: TextStyle(
            color: AppTheme.greyColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Builder(builder: (context) {
          if (viewModel is CurrencyConverterLoading) {
            return CupertinoActivityIndicator();
          }

          return Text(
            currencyState.isReverse
                ? '1 ${currencyState.targetCode} = ${currencyState.conversionRate} ${currencyState.baseCode}'
                : '1 ${currencyState.baseCode} = ${currencyState.conversionRate} ${currencyState.targetCode}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          );
        }),
      ],
    );
  }
}