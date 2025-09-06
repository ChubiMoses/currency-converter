import 'package:ccapp/data/view_model/currency_converter_states.dart';
import 'package:ccapp/data/view_model/currency_converter_view_model.dart';
import 'package:ccapp/utils/theme.dart';
import 'package:ccapp/utils/utils_provider.dart';
import 'package:ccapp/widgets/notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class ExchangeRateWidget extends ConsumerStatefulWidget {
  const ExchangeRateWidget({super.key});

  @override
  ConsumerState<ExchangeRateWidget> createState() => _ExchangeRateWidgetState();
}

class _ExchangeRateWidgetState extends ConsumerState<ExchangeRateWidget> {
  @override
  Widget build(BuildContext context) {
    final utilsProvider = context.watch<UtilsProvider>();
    final viewModel = ref.watch(currencyConverterVM);

    // Handle error state outside of build method
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
              utilsProvider.isReverse 
                ? '1 ${utilsProvider.targetCode} = ${utilsProvider.converstionRate} ${utilsProvider.baseCode}' 
                : '1 ${utilsProvider.baseCode} = ${utilsProvider.converstionRate} ${utilsProvider.targetCode}',
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