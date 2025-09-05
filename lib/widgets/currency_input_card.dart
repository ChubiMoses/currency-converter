
import 'package:ccapp/data/view_model/currency_converter_states.dart';
import 'package:ccapp/data/view_model/currency_converter_view_model.dart';
import 'package:ccapp/utils/asset_images.dart';
import 'package:ccapp/utils/debouncer.dart';
import 'package:ccapp/utils/theme.dart';
import 'package:ccapp/utils/utils_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

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
    final utilsProvider = context.watch<UtilsProvider>();
    final viewModel = ref.watch(currencyConverterVM);

    return Builder(builder: (context) {
      if (viewModel is CurrencyConverterLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }

      if (viewModel is CurrencyConverterLoaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          utilsProvider.updateRate(viewModel.currencyConverterViewViewModel.conversionRate.toString());
          if (!utilsProvider.isReverse) {
            utilsProvider.targetAmountController.text = 
                viewModel.currencyConverterViewViewModel.conversionResult.toString();
          } else {
            utilsProvider.baseAmountController.text = 
                viewModel.currencyConverterViewViewModel.conversionResult.toString();
          }
        });
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isBase ? utilsProvider.baseCode : utilsProvider.targetCode,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InkWell(
                onTap: () => _showCurrencyPicker(context, utilsProvider),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage:AssetImage(widget.isBase ? utilsProvider.baseFlag : utilsProvider.targetFlag,),
                      child: Text(
                        widget.isBase ? utilsProvider.baseCode : utilsProvider.targetCode,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.isBase ? utilsProvider.baseCode : utilsProvider.targetCode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    _debouncer.run(() {
                      if (text.isNotEmpty) {
                        if(!widget.isBase){
                          utilsProvider.setReverse(true);
                        } else {
                          utilsProvider.setReverse(false);
                        }
                        ref.read(currencyConverterVM.notifier).currencyConverter(
                          baseCode: widget.isBase ? utilsProvider.baseCode : utilsProvider.targetCode,
                          targetCode: widget.isBase ? utilsProvider.targetCode : utilsProvider.baseCode,
                          amount: text,
                        );
                      }
                    });
                  },
                  controller: widget.isBase ? utilsProvider.baseAmountController : utilsProvider.targetAmountController,
                  textAlign: TextAlign.right,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xFFEFEFEF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide(width: 1, color: Color(0xFFEFEFEF))
                    ),
                    contentPadding: EdgeInsets.all(8),
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
    });
  }

  void _showCurrencyPicker(BuildContext context, UtilsProvider utilsProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.symmetric(vertical:16, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Center(
                child: Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTheme.lightGrey
                  ),
                ),
              ),
              SizedBox(height: 15,),
              const Text(
                'Select Balance',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildCurrencyTile(context, utilsProvider, 'SDG', '0.0', 'European Union', CurrencyFlags.sdg ),
                    _buildCurrencyTile(context, utilsProvider, 'USD', '0.0', 'United States', CurrencyFlags.usd ),
                    _buildCurrencyTile(context, utilsProvider, 'GBP', '0.0', 'United Kingdom', CurrencyFlags.gbp ),
                    _buildCurrencyTile(context, utilsProvider, 'JPY', '0.0', 'Japan', CurrencyFlags.jpy ),
                    _buildCurrencyTile(context, utilsProvider, 'EUR', '0.0', 'European Union', CurrencyFlags.eur),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrencyTile(BuildContext context, UtilsProvider utilsProvider, String code, String symbol, String country, String flag) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
       backgroundImage: AssetImage(flag),
      ),
      title: Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(country),
      trailing: Text(
        symbol,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () {
        if (widget.isBase) {
          utilsProvider.setBaseCode(code);
        } else {
          utilsProvider.setTargetCode(code);
        }
        Navigator.pop(context);
      },
    );
  }
}