
import 'package:ccapp/data/view_model/currency_converter_states.dart';
import 'package:ccapp/data/view_model/currency_converter_view_model.dart';
import 'package:ccapp/providers/currency_providers.dart';
import 'package:ccapp/utils/debouncer.dart';
import 'package:ccapp/utils/theme.dart';
import 'package:ccapp/widgets/currency_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyInputCard extends ConsumerStatefulWidget {
  final bool isBase;

  const CurrencyInputCard({
    super.key,
    required this.isBase,
  });

  @override
  ConsumerState<CurrencyInputCard> createState() => _CurrencyInputCardState();
}

class _CurrencyInputCardState extends ConsumerState<CurrencyInputCard> {
  final Debouncer _debouncer = Debouncer(milliseconds: 600);

  @override
  Widget build(BuildContext context) {
    final currencyState = ref.watch(currencyStateProvider);
    final viewModel = ref.watch(currencyConverterVM);

    if (viewModel is CurrencyConverterLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!currencyState.isSwap) {
          ref.read(currencyStateProvider.notifier).updateRate(
              viewModel.currencyConverterViewViewModel.conversionRate.toString());
          if (!currencyState.isReverse) {
            currencyState.targetAmountController.text =
                viewModel.currencyConverterViewViewModel.conversionResult.toString();
          } else {
            currencyState.baseAmountController.text =
                viewModel.currencyConverterViewViewModel.conversionResult.toString();
          }
        }
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isBase ? "Amount" : "Converted Amount",
          style: const TextStyle(
            color: AppTheme.greyColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            InkWell(
              onTap: () => _showCurrencyPicker(context),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(
                      widget.isBase ? currencyState.baseFlag : currencyState.targetFlag,
                    ),
                    child: Text(
                      widget.isBase ? currencyState.baseCode : currencyState.targetCode,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.isBase ? currencyState.baseCode : currencyState.targetCode,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: AppTheme.greyColor),
                ],
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: SizedBox(
                width: 200,
                child: TextField(
                  onChanged: (text) {
                    _debouncer.run(() {
                      if (text.isNotEmpty) {
                        final notifier = ref.read(currencyStateProvider.notifier);
                        if (!widget.isBase) {
                          notifier.setReverse(true);
                        } else {
                          notifier.setReverse(false);
                        }
                        notifier.setSwap(false);

                        FocusManager.instance.primaryFocus?.unfocus();

                        ref.read(currencyConverterVM.notifier).currencyConverter(
                              baseCode: widget.isBase
                                  ? currencyState.baseCode
                                  : currencyState.targetCode,
                              targetCode: widget.isBase
                                  ? currencyState.targetCode
                                  : currencyState.baseCode,
                              amount: text,
                            );
                      }
                    });
                  },
                  controller: widget.isBase
                      ? currencyState.baseAmountController
                      : currencyState.targetAmountController,
                  textAlign: TextAlign.right,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppTheme.textFieldColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide:
                          BorderSide(width: 1, color: AppTheme.textFieldColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide:
                          BorderSide(width: 1, color: AppTheme.textFieldColor),
                    ),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CurrencyBottomSheet(isBase: widget.isBase),
    );
  }

}