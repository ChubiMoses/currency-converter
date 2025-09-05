import 'package:ccapp/utils/asset_images.dart';
import 'package:ccapp/utils/utils_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SwapImageIconWidget extends StatelessWidget {
  const SwapImageIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 1.5,
              width: MediaQuery.of(context).size.width - 20,
              color: Color(0xFFE7E7EE),
            ),
          ),
           Center(
            child: InkWell(
              onTap: (){
                final utilsProvider = context.read<UtilsProvider>();
                // Swap base currency to target currency
                final tempCode = utilsProvider.baseCode;
                final tempAmount = utilsProvider.baseAmountController.text;
                
                // Update base with target values
                utilsProvider.setBaseCode(utilsProvider.targetCode);
                utilsProvider.baseAmountController.text = utilsProvider.targetAmountController.text;
                
                // Update target with base values
                utilsProvider.setTargetCode(tempCode);
                utilsProvider.targetAmountController.text = tempAmount;
              },
              child: CircleAvatar(
                backgroundColor: Color(0xFF1A237E),
                child: SvgPicture.asset(AssetIcons.swap,)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
