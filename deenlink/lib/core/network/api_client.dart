import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  static Dio? _dio;
  static PersistCookieJar? _cookieJar;

  static const String baseUrl = "https://deenlink.org/api";

  static Future<Dio> getInstance() async {
    if (_dio != null) return _dio!;
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies/';

    _cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio!.interceptors.add(CookieManager(_cookieJar!));

    _dio!.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    return _dio!;
  }

  static Future<void> clearCookies() async {
    await _cookieJar?.deleteAll();
  }
}
