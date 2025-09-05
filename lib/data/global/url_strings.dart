
import 'package:ccapp/data/global/constants.dart';

class URLString{

   static String get apiKey => const String.fromEnvironment('API_KEY', 
    defaultValue: '');  
  static const  baseUrl = "https://v6.exchangerate-api.com/";
  static String get currencyConverterUrl => "$baseUrl/v6/${Constants.apiKey}/pair/";
  
}