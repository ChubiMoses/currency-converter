import 'package:flutter/material.dart';

class SwapWidget extends StatelessWidget {
  const SwapWidget({super.key});

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
          const Center(
            child: CircleAvatar(
              backgroundColor: Color(0xFF1A237E),
              child: Icon(Icons.swap_vert, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
