part of network;

final networkProvider = Provider<Network>((ref) {
  return Network();
});

class Network {
  static const connectTimeOut = Duration(seconds: 60);
  static const receiverTimeOut = Duration(seconds: 60);
  late Dio dio;
  late bool showLog;

  final _dioBaseOptions = BaseOptions(
    connectTimeout: connectTimeOut,
    receiveTimeout: receiverTimeOut,
    baseUrl: URLString.baseUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  Network({String? baseUrl, this.showLog = false}) {
    dio = Dio();
    dio.interceptors.add(ApiInterceptor());
    dio.options = _dioBaseOptions;
    if (baseUrl != null) dio.options.baseUrl = baseUrl;
    if (showLog) {
      dio.interceptors.add(
       LogInterceptor(requestBody: true, logPrint: printDioLogs),
      );
    }
  }

  Network.noInterceptor([String? baseUrl]) {
    dio = Dio();
    if (baseUrl != null) dio.options.baseUrl = baseUrl;
    dio.options = _dioBaseOptions;
  }

  /// Factory constructor used mainly for injecting an instance of [Dio] mock
  Network.test(this.dio);

  Future<Response> call(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    data,
    FormData? formData,
    ResponseType responseType = ResponseType.json,
    String classTag = '',
    bool? showLog,
  }) async {
    Response? response;
    var params = queryParams ?? {};
    try {
      switch (method) {
        case RequestMethod.post:
          response = await dio.post(
            path,
            queryParameters: params,
            data: data,
            options: Options(responseType: responseType, headers: headers),
          );
          break;
        case RequestMethod.get:
          response = await dio.get(path,
              queryParameters: params,
              options:
                  Options(headers: headers, responseType: ResponseType.json));
          break;
        case RequestMethod.put:
          response = await dio.put(path, queryParameters: params, data: data);
          break;
        case RequestMethod.delete:
          response = await dio.delete(
            path,
            queryParameters: params,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case RequestMethod.upload:
          response = await dio.post(
            path,
            data: formData,
            queryParameters: params,
            options: Options(headers: headers
                ),
            onSendProgress: (sent, total) {
            },
          );
          break;
      }
      if (showLog ?? false) log("$path API response: $response");
      return response;
    } on DioException catch (error, stackTrace) {
      final apiError = ApiError.fromDioError(error);
      if (showLog ?? false) {
        log("$path: ${error.response?.statusCode} code");
        log("API response: ${error.response}");
      }
      print(stackTrace);
      print("ERROR RESPONSE: ${error.response}");
      print("ERROR MESSAGE: ${error.message}");
      return Future.error(
          error.response?.data["message"] ??
              error.response?.data["errors"] ??
              apiError ??
              "",
          stackTrace);
    } catch (_) {
      rethrow;
    }
  }
}

enum RequestMethod { post, get, put, delete, upload }
