import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../network/api_client.dart';
import '../models/user.dart';

//expandable floating action button.
class AuthRemoteRepository {
  Future<User> login({required String email, required String password}) async {
    final dio = await ApiClient.getInstance();

    try {
      final response = await dio.post(
        '/auth/login.php',
        data: {'email': email, 'password': password},
      );

      if (response.data['success'] == true || response.statusCode == 200) {
        final userData =
            response.data['user'] ??
            response.data['data']?['user'] ??
            response.data;
        return User.fromJson(userData as Map<String, dynamic>);
      }
      throw Exception(response.data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> register({
    required String fullname,
    required String email,
    required String username,
    String? gender,
    String? country,
    String? aqeedah,
    required String password,
    required String confirmPassword,
    required bool agreeToTerms,
  }) async {
    final dio = await ApiClient.getInstance();

    try {
      final response = await dio.post(
        'auth/register.php',
        data: {
          'fullname': fullname,
          'email': email,
          'username': username,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.data['success'] == true ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
        final userData =
            response.data['user'] ??
            response.data['data']?['user'] ??
            response.data;
        return User.fromJson(userData as Map<String, dynamic>);
      }
      throw Exception(response.data['message'] ?? 'Registration failed!');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User?> getCurrentUser() async {
    final dio = await ApiClient.getInstance();
    try {
      final response = await dio.get("/auth/me.php");

      if (response.statusCode == 200) {
        final userData =
            response.data['user'] ?? response.data['data'] ?? response.data;
        return User.fromJson(userData as Map<String, dynamic>);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) return null;
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    final dio = await ApiClient.getInstance();

    try {
      await dio.post('/auth/logout.php');
    } catch (_) {
    } finally {
      await ApiClient.clearCookies();
    }
  }

  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Check your internet.');

      case DioExceptionType.badResponse:
        final message =
            e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server error (${e.response?.statusCode})';
        return Exception(message);

      case DioExceptionType.connectionError:
        return Exception('No internet connection.');

      default:
        return Exception('Something went wrong. Try again');
    }
  }
}
