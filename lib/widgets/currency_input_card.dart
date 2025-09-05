
import 'package:ccapp/data/view_model/currency_converter_states.dart';
import 'package:ccapp/data/view_model/currency_converter_view_model.dart';
import 'package:ccapp/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyInputCard extends ConsumerStatefulWidget {
  final String label;
  final String flag;
  final String currencyCode;
  final String amount;
  final String type;

  const CurrencyInputCard({
    super.key,
    required this.label,
     required this.type,
    required this.flag,
    required this.currencyCode,
    required this.amount,
  });

  @override
  ConsumerState<CurrencyInputCard> createState() => _CurrencyInputCardState();
}

class _CurrencyInputCardState extends ConsumerState<CurrencyInputCard> {
  final Debouncer _debouncer = Debouncer(milliseconds: 600);
  TextEditingController baseAmountController = TextEditingController(text: "0.0");
  TextEditingController targetAmountController = TextEditingController(text: "0.0");
  String baseCode = "EUR";
  String targetCode = "GBP";



 @override
  void dispose() {
    baseAmountController.dispose();
      targetAmountController.dispose();
    _debouncer.timer?.cancel(); // Cancel any pending timer on dispose
    super.dispose();
  }



  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Currency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildCurrencyTile('EUR', '€', 'European Union'),
                    _buildCurrencyTile('USD', '\$', 'United States'),
                    _buildCurrencyTile('GBP', '£', 'United Kingdom'),
                    _buildCurrencyTile('JPY', '¥', 'Japan'),
                    _buildCurrencyTile('AUD', '\$', 'Australia'),
                    // Add more currencies as needed
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrencyTile(String code, String symbol, String country) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(code.substring(0, 2)),
      ),
      title: Text(code),
      subtitle: Text(country),
      trailing: Text(
        symbol,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () {
        setState(() {
          if (widget.type == "Base") {
            baseCode = code;
          } else {
            targetCode = code;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(currencyConverterVM);

    return  Builder(builder: (context) {
      if (viewModel is CurrencyConverterLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }

       if (viewModel is CurrencyConverterLoaded) {
          targetAmountController.text = viewModel.allCurrencyConverterModel.conversionResult.toString();

       }
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            GestureDetector(
              onTap: _showCurrencyPicker,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    child: Text(
                      widget.flag,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.type == "Base" ? baseCode : targetCode,
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
                    // This code will execute after the user stops typing for 'milliseconds'
                    if(baseAmountController.text.isNotEmpty && targetAmountController.text.isNotEmpty){
                       ref.read(currencyConverterVM.notifier).currencyConverter(baseCode: baseCode,targetCode:targetCode,amount:widget.type == "Base" ?  baseAmountController.text : targetAmountController.text);

                    }

                  });

               
                },
                controller: widget.type == "Base" ?  baseAmountController : targetAmountController,
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
    });
  }
}