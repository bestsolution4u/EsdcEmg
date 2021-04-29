import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:esdc_emg/config/global.dart';

Map<String, dynamic> dioErrorHandle(DioError error) {
  print('DIO ERROR: $error');
  switch (error.type) {
    case DioErrorType.response:
      return error.response?.data;
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return {"success": false, "code": "request_time_out"};

    default:
      return {"success": false, "code": "connect_to_server_fail"};
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: Globals.BASE_URL,
  );

  ///Post method
  Future<dynamic> post({
    String url,
    Map<String, dynamic> data,
    Options options,
  }) async {
    print('POST REQUEST: $url');
    print('PARAMS: $data');
    Dio dio = new Dio(baseOptions);

    try {
      final response = await dio.post(
        url,
        data: data,
        options: generateOptions(),
      );
      print('----------- API response -----------');
      print(response);
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({
    String url,
    Map<String, dynamic> params,
    Options options,
  }) async {
    print('GET REQUEST: $url');
    print('PARAMS: $params');
    Dio dio = new Dio(baseOptions);
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: generateOptions(),
      );
      print('----------- API response -----------');
      print(response);
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  Options generateOptions() {
    String username = 'apiadmin';
    String password = 'apiadmin123';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return Options(headers: <String, String>{'authorization': basicAuth});
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
