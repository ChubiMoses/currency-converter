import 'package:ccapp/providers/currency_providers.dart';
import 'package:ccapp/utils/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SwapImageIconWidget extends ConsumerWidget {
  const SwapImageIconWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 1.5,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Color(0xFFE7E7EE),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                final notifier = ref.read(currencyStateProvider.notifier);
                notifier.setSwap(true);
                notifier.swapCurrencies();
              },
              child: CircleAvatar(
                backgroundColor: Color(0xFF1A237E),
                child: SvgPicture.asset(AssetIcons.swap),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
