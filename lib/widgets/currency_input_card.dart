
import 'package:flutter/material.dart';

class CurrencyInputCard extends StatelessWidget {
  final String label;
  final String flag;
  final String currencyCode;
  final String amount;

  const CurrencyInputCard({
    super.key,
    required this.label,
    required this.flag,
    required this.currencyCode,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              child: Text(
                flag,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              currencyCode,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down),
            const Spacer(),
            Expanded(
              child: TextFormField(
                onEditingComplete: () {
                  
                },
                controller: TextEditingController(text: amount),
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
  }
}