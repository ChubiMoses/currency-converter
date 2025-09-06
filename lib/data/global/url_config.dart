
import 'package:ccapp/data/global/api_key.dart';

class UrlConfig{

   static String get apiKey => const String.fromEnvironment('API_KEY', 
    defaultValue: '');  
  static const  baseUrl = "https://v6.exchangerate-api.com/";
  static String get currencyConverterUrl => "$baseUrl/v6/${Apikey.apiKey}/pair/";
  
}