import 'package:ccapp/utils/asset_images.dart';
import 'package:flutter/widgets.dart';

class UtilsProvider extends ChangeNotifier {
 

  final TextEditingController _baseAmountController = TextEditingController(text: "0.0");
  final TextEditingController _targetAmountController = TextEditingController(text: "0.0");

  String _baseCode = "EUR";
  String _targetCode = "GBP";
  String _converstionRate = "--";
  

  bool _isReverse = false;
   bool _isSwap = false;
  
  bool get isReverse => _isReverse;
  bool get isSwap => _isSwap;
 
  TextEditingController get baseAmountController =>  _baseAmountController;
  TextEditingController get targetAmountController => _targetAmountController;
  String get baseCode => _baseCode;
  String get targetCode => _targetCode;
  String get converstionRate => _converstionRate;
  
  
  
   void setSwap(bool value) {
    _isSwap = value;
    notifyListeners();
  }
  
  void updateRate(String value) {
    _converstionRate = value;
    notifyListeners();
  }

 
  void setReverse(bool value) {
    _isReverse = value;
    notifyListeners();
  }

  void setBaseCode(String code) {
    _baseCode = code;
    notifyListeners();
  }

   void setBaseFlag(String code) {
    _baseCode = code;
    notifyListeners();
  }

  void setTargetCode(String code) {
    _targetCode = code;
    notifyListeners();
  }

  void initFields(){
    _baseAmountController.text = "0.0";
    _targetAmountController.text = "0.0";
    _converstionRate = "--";

    notifyListeners();
  }


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

  @override
  void dispose() {
    _targetAmountController.dispose();
    _targetAmountController.dispose();
    super.dispose();
  }
}