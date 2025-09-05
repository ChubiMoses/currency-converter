class CurrencyConverterModel {
    CurrencyConverterModel({
        required this.result,
        required this.documentation,
        required this.termsOfUse,
        required this.timeLastUpdateUnix,
        required this.timeLastUpdateUtc,
        required this.timeNextUpdateUnix,
        required this.timeNextUpdateUtc,
        required this.baseCode,
        required this.targetCode,
        required this.conversionRate,
        required this.conversionResult,
    });

    final String? result;
    final String? documentation;
    final String? termsOfUse;
    final int? timeLastUpdateUnix;
    final String? timeLastUpdateUtc;
    final int? timeNextUpdateUnix;
    final String? timeNextUpdateUtc;
    final String? baseCode;
    final String? targetCode;
    final double? conversionRate;
    final double? conversionResult;

    factory CurrencyConverterModel.fromJson(Map<String, dynamic> json){ 
        return CurrencyConverterModel(
            result: json["result"],
            documentation: json["documentation"],
            termsOfUse: json["terms_of_use"],
            timeLastUpdateUnix: json["time_last_update_unix"],
            timeLastUpdateUtc: json["time_last_update_utc"],
            timeNextUpdateUnix: json["time_next_update_unix"],
            timeNextUpdateUtc: json["time_next_update_utc"],
            baseCode: json["base_code"],
            targetCode: json["target_code"],
            conversionRate: json["conversion_rate"],
            conversionResult: json["conversion_result"],
        );
    }

}
