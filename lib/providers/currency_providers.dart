import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccapp/utils/asset_images.dart';

// State class for currency conversion
class CurrencyState {
  final TextEditingController baseAmountController;
  final TextEditingController targetAmountController;
  final String baseCode;
  final String targetCode;
  final String conversionRate;
  final bool isReverse;
  final bool isSwap;

  CurrencyState({
    required this.baseAmountController,
    required this.targetAmountController,
    this.baseCode = "EUR",
    this.targetCode = "GBP",
    this.conversionRate = "--",
    this.isReverse = false,
    this.isSwap = false,
  });

  CurrencyState copyWith({
    TextEditingController? baseAmountController,
    TextEditingController? targetAmountController,
    String? baseCode,
    String? targetCode,
    String? conversionRate,
    bool? isReverse,
    bool? isSwap,
  }) {
    return CurrencyState(
      baseAmountController: baseAmountController ?? this.baseAmountController,
      targetAmountController: targetAmountController ?? this.targetAmountController,
      baseCode: baseCode ?? this.baseCode,
      targetCode: targetCode ?? this.targetCode,
      conversionRate: conversionRate ?? this.conversionRate,
      isReverse: isReverse ?? this.isReverse,
      isSwap: isSwap ?? this.isSwap,
    );
  }

  String get baseFlag {
    switch (baseCode) {
      case "USD": return CurrencyFlags.usd;
      case "EUR": return CurrencyFlags.eur;
      case "GBP": return CurrencyFlags.gbp;
      case "JPY": return CurrencyFlags.jpy;
      case "SDG": return CurrencyFlags.sdg;
      default: return CurrencyFlags.eur;
    }
  }

  String get targetFlag {
    switch (targetCode) {
      case "USD": return CurrencyFlags.usd;
      case "EUR": return CurrencyFlags.eur;
      case "GBP": return CurrencyFlags.gbp;
      case "JPY": return CurrencyFlags.jpy;
      case "SDG": return CurrencyFlags.sdg;
      default: return CurrencyFlags.eur;
    }
  }
}

// StateNotifier for managing currency state
class CurrencyStateNotifier extends StateNotifier<CurrencyState> {
  CurrencyStateNotifier() : super(CurrencyState(
    baseAmountController: TextEditingController(text: "0"),
    targetAmountController: TextEditingController(text: "0"),
  ));

  void setBaseCode(String code) {
    state = state.copyWith(baseCode: code);
  }

  void setTargetCode(String code) {
    state = state.copyWith(targetCode: code);
  }

  void setReverse(bool value) {
    state = state.copyWith(isReverse: value);
  }

  void setSwap(bool value) {
    state = state.copyWith(isSwap: value);
  }

  void updateRate(String value) {
    state = state.copyWith(conversionRate: value);
  }

  void initFields() {
    state.baseAmountController.text = "0";
    state.targetAmountController.text = "0";
    state = state.copyWith(conversionRate: "--");
  }

  void swapCurrencies() {
    final tempCode = state.baseCode;
    setBaseCode(state.targetCode);
    setTargetCode(tempCode);
    initFields();
  }
}

// Provider for currency state
final currencyStateProvider = StateNotifierProvider<CurrencyStateNotifier, CurrencyState>((ref) {
  return CurrencyStateNotifier();
});