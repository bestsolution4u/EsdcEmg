import 'package:dio/dio.dart';
import 'package:esdc_emg/config/global.dart';

Map<String, dynamic> dioErrorHandle(DioError error) {
  print('DIO ERROR: $error');
  switch (error.type) {
    case DioErrorType.RESPONSE:
      return error.response?.data;
    case DioErrorType.SEND_TIMEOUT:
    case DioErrorType.RECEIVE_TIMEOUT:
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
        options: options,
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
        options: options,
      );
      print('----------- API response -----------');
      print(response);
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
