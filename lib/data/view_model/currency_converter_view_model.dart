
import 'package:ccapp/data/models/currency_conveter_model.dart';
import 'package:ccapp/data/view_model/currency_converter_states.dart';
import 'package:ccapp/repository/currency_converter_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyConverterViewViewModel extends StateNotifier<CurrencyConverterStates> {
  final Ref ref;
  CurrencyConverterViewViewModel(this.ref) : super(CurrencyConverterInitial());

  Future<CurrencyConverterModel> currencyConverter(String baseCode, String targetCode, double amount) async {
    try {
      state = CurrencyConverterLoading();
      final result = await ref.read(currencyConverterRepo).fetchExchangeRate(baseCode, targetCode, amount);
      state = CurrencyConverterLoaded(result);
      return result;
    } catch (e) {
      state = CurrencyConverterError(e.toString());
      rethrow;
    }
  }
}

final currencyConverterVVM =
StateNotifierProvider.autoDispose<CurrencyConverterViewViewModel, CurrencyConverterStates>(
        (ref) => CurrencyConverterViewViewModel(ref));
