import 'package:ccapp/data/global/url_strings.dart';
import 'package:ccapp/data/models/currency_conveter_model.dart';
import 'package:ccapp/data/repository/network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyConverterRepo {
  final Dio dio = Dio();
  

  Future<CurrencyConverterModel> fetchExchangeRate(String baseCode, String targetCode, double amount) async {
    try {
      String path = '${URLString.currencyConverterUrl}$baseCode/$targetCode/${amount.toString()}';
      final response =
          await Network.noInterceptor().call(path, RequestMethod.get);
      final responseModel = CurrencyConverterModel.fromJson(response.data);
      return responseModel;
    } catch (error) {
      rethrow;
    }
  }



}

final currencyConverterRepo = Provider((ref) => CurrencyConverterRepo());
