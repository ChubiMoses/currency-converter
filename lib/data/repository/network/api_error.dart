part of 'network.dart';

class ApiError implements Exception {
  final String errorDescription;
  final dynamic data;
  final DioErrorType? dioErrorType;
  final int? statusCode;
  static const unknownError = 'Something went wrong, please try again';
  static const internetError = 'Internet connection error, please try again';
  static const cancelError = 'API request canceled, please try again';
  static const internetError2 =
      'Please check your internet connection , seems you are offline';

  ApiError({
    required this.errorDescription,
    this.data,
    this.dioErrorType,
    this.statusCode,
  });

  factory ApiError.fromDioError(DioError error) {
    try {
      String description = '';
      switch (error.type) {
        case DioErrorType.badCertificate:
        case DioErrorType.connectionTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          description = unknownError;
          break;
        case DioErrorType.badResponse:
          description = extractDescriptionFromResponse(error.response);
          break;
        case DioErrorType.cancel:
          description = cancelError;
          break;
        case DioErrorType.unknown:
        case DioErrorType.connectionError:
          description = unknownError;
          if (error.error is SocketException) {
            description = internetError;
          } else {
            description = unknownError;
          }
          break;
      }
      return ApiError(
        errorDescription: description,
        dioErrorType: error.type,
        data:
        error.response?.data != null ? error.response?.data['data'] : null,
        statusCode: error.response?.statusCode,
      );
    } catch (_) {
      throw unknownError;
    }
  }

  static String extractDescriptionFromResponse(Response? response) {
    try {
      if (response!.statusCode! >= 500) {
        return 'Internal Server error, please try again later';
      }
      if (response.data != null && response.data['message'] != null) {
        return response.data['message'] as String;
      } else {
        return response.statusMessage ?? '';
      }
    } catch (error) {
      throw unknownError;
    }
  }

  @override
  String toString() => errorDescription;
}