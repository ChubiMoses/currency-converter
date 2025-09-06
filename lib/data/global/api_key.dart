class Apikey {
  static String get apiKey => const String.fromEnvironment('API_KEY', 
    defaultValue: '');  
}
