import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            child: CircleAvatar(
              backgroundColor: Color(0xFF1A237E),
              child: SvgPicture.asset("assets/images/swap.svg",)
            ),
          ),
        ],
      ),
    );
  }
}
