import 'package:dio/dio.dart';
import 'package:tijara/constent/app_constant.dart';

class DioHelper {
  static late Dio dio;
  static initDio() {
    dio = Dio(BaseOptions(
        baseUrl: AppConstant.baseApiPayment,
        headers: {"Content-Type": 'application/json'},
        receiveDataWhenStatusError: true
        )
        
        );
  }
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return await dio.post(url, data: data, queryParameters: query);
  }
}
