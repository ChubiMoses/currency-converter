import 'package:ccapp/data/models/currency_conveter_model.dart';

abstract class CurrencyConverterStates {}

class CurrencyConverterInitial extends CurrencyConverterStates {}

class CurrencyConverterLoading extends CurrencyConverterStates {}

class CurrencyConverterSuccess extends CurrencyConverterStates {}

class CurrencyConverterLoaded extends CurrencyConverterStates {
  final CurrencyConverterModel currencyConverterViewViewModel;

CurrencyConverterLoaded(this.currencyConverterViewViewModel);
}
class CurrencyConverterError extends CurrencyConverterStates {
  final String error;

  CurrencyConverterError(this.error);
}
