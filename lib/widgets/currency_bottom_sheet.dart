import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccapp/providers/currency_providers.dart';
import 'package:ccapp/utils/asset_images.dart';
import 'package:ccapp/utils/theme.dart';

class CurrencyBottomSheet extends ConsumerWidget {
  final bool isBase;

  const CurrencyBottomSheet({
    super.key,
    required this.isBase,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.lightGrey,
              ),
            ),
          ),
          const SizedBox(height: 15),
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
                _buildCurrencyTile(context, ref, 'SDG', 'Sudan', CurrencyFlags.sdg),
                _buildCurrencyTile(context, ref, 'USD', 'United States', CurrencyFlags.usd),
                _buildCurrencyTile(context, ref, 'GBP', 'United Kingdom', CurrencyFlags.gbp),
                _buildCurrencyTile(context, ref, 'JPY', 'Japan', CurrencyFlags.jpy),
                _buildCurrencyTile(context, ref, 'EUR', 'European Union', CurrencyFlags.eur),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyTile(BuildContext context, WidgetRef ref, String code, String country, String flag) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: AssetImage(flag),
      ),
      title: Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(country),
      trailing: Text(
        '0.0',
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () {
        if (isBase) {
          ref.read(currencyStateProvider.notifier).setBaseCode(code);
        } else {
          ref.read(currencyStateProvider.notifier).setTargetCode(code);
        }
        Navigator.pop(context);
      },
    );
  }
}