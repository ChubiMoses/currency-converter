import 'package:ccapp/utils/asset_images.dart';
import 'package:flutter/widgets.dart';

class UtilsProvider extends ChangeNotifier {
  // Controllers for managing input amounts in base and target currency fields
  final TextEditingController _baseAmountController = TextEditingController(text: "0.0");
  final TextEditingController _targetAmountController = TextEditingController(text: "0.0");

  // Currency codes for base and target currencies
  String _baseCode = "EUR";
  String _targetCode = "GBP";
  String _converstionRate = "--";
  
  // Flags to track conversion direction and swap state
  bool _isReverse = false;  // Tracks if conversion is from target to base
  bool _isSwap = false;     // Tracks if currencies have been swapped
  
  // Getters for accessing private fields
  bool get isReverse => _isReverse;
  bool get isSwap => _isSwap;
  TextEditingController get baseAmountController => _baseAmountController;
  TextEditingController get targetAmountController => _targetAmountController;
  String get baseCode => _baseCode;
  String get targetCode => _targetCode;
  String get converstionRate => _converstionRate;
  
  /// Sets the swap state and notifies listeners
  void setSwap(bool value) {
    _isSwap = value;
    notifyListeners();
  }
  
  /// Updates the conversion rate and notifies listeners
  void updateRate(String value) {
    _converstionRate = value;
    notifyListeners();
  }

  /// Sets the reverse conversion flag and notifies listeners
  void setReverse(bool value) {
    _isReverse = value;
    notifyListeners();
  }

  /// Updates the base currency code and notifies listeners
  void setBaseCode(String code) {
    _baseCode = code;
    notifyListeners();
  }

  /// Updates the base currency flag (Deprecated - redundant method)
  void setBaseFlag(String code) {
    _baseCode = code;
    notifyListeners();
  }

  /// Updates the target currency code and notifies listeners
  void setTargetCode(String code) {
    _targetCode = code;
    notifyListeners();
  }

  /// Resets all fields to their initial values
  void initFields() {
    _baseAmountController.text = "0.0";
    _targetAmountController.text = "0.0";
    _converstionRate = "--";
    notifyListeners();
  }

  /// Returns the flag asset path for the base currency
  String get baseFlag {
    switch (_baseCode) {
      case "USD":
        return CurrencyFlags.usd;
      case "EUR":
        return CurrencyFlags.eur;
      case "GBP":
        return CurrencyFlags.gbp;
      case "JPY":
        return CurrencyFlags.jpy;
      case "SDG":
        return CurrencyFlags.sdg;
      default:
        return CurrencyFlags.eur;
    }
  }

  /// Returns the flag asset path for the target currency
  String get targetFlag {
    switch (_targetCode) {
      case "USD":
        return CurrencyFlags.usd;
      case "EUR":
        return CurrencyFlags.eur;
      case "GBP":
        return CurrencyFlags.gbp;
      case "JPY":
        return CurrencyFlags.jpy;
      case "SDG":
        return CurrencyFlags.sdg;
      default:
        return CurrencyFlags.eur;
    }
  }

  /// Cleans up resources when the provider is disposed
  @override
  void dispose() {
    _targetAmountController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }
}