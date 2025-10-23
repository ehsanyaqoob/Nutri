import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nutri/config/api_endpoint/config.dart';
import 'package:nutri/services/api_services/api_response.dart';
import 'package:nutri/services/api_services/networ_exception.dart';
import 'package:nutri/services/storage-services.dart';

class ApiService {
  final String baseUrl = '${Config.pro_base_url}api';

  Future<Map<String, String>> _getHeaders(bool authorization) async {
    final headers = {'Content-Type': 'application/json'};
    if (authorization) {
      headers['Authorization'] = 'Bearer ${await Storage.authToken}';
    }
    return headers;
  }

  Future<ApiResponse<T>> _handleRequest<T>({
    required Future<http.Response> request,
    required T Function(dynamic) fromJson,
  }) async {
    if (!await InternetConnectionChecker.createInstance().hasConnection) {
      throw NetworkException('No Internet Connection');
    }

    final response = await request;

    // ADD RESPONSE BODY PRINTING HERE
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    // ✅ FIX: Handle all common HTTP status codes including 401
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      // Success codes (200-299)
      final Map<String, dynamic> data = json.decode(response.body);
      final apiResponse = ApiResponse<T>.fromJson(data, fromJson);
      
      return ApiResponse<T>(
        success: apiResponse.success, 
        message: apiResponse.message,
        data: apiResponse.data,
        statusCode: response.statusCode,
        errors: apiResponse.errors,
        errorCode: apiResponse.errorCode,
      );
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      // ✅ FIX: Handle all client errors (400-499) including 401
      final Map<String, dynamic> data = json.decode(response.body);
      final apiResponse = ApiResponse<T>.fromJson(data, fromJson);
      
      return ApiResponse<T>(
        success: false, // Mark as failure for 4xx errors
        message: apiResponse.message ?? _getDefaultErrorMessage(response.statusCode),
        data: apiResponse.data,
        statusCode: response.statusCode,
        errors: apiResponse.errors,
        errorCode: apiResponse.errorCode,
      );
    } else {
      // Server errors (500-599) and others
      throw NetworkException('Server responded with status: ${response.statusCode}');
    }
  }

  // ✅ Helper method for default error messages
  String _getDefaultErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 422:
        return 'Validation Error';
      default:
        return 'Request failed with status $statusCode';
    }
  }

  Future<ApiResponse<T>> get<T>(
    String endpoint,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';
    
    print('GET Request: $fullUrl');
    print('Headers: $headers');

    return _handleRequest<T>(
      request: http.get(Uri.parse(fullUrl), headers: headers),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint,
    Map<String, dynamic> body,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';
    
    body['version'] = '3.0.1';
    
    print('POST Request: $fullUrl');
    print('Headers: $headers');
    print('Request Body: ${json.encode(body)}');

    return _handleRequest<T>(
      request: http.post(
        Uri.parse(fullUrl),
        headers: headers,
        body: json.encode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint,
    Map<String, dynamic> body,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';
    
    print('PUT Request: $fullUrl');
    print('Headers: $headers');
    print('Request Body: ${json.encode(body)}');

    return _handleRequest<T>(
      request: http.put(
        Uri.parse(fullUrl),
        headers: headers,
        body: json.encode(body),
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint,
    bool authorization,
    T Function(dynamic) fromJson,
  ) async {
    final headers = await _getHeaders(authorization);
    final String fullUrl = '$baseUrl$endpoint';
    
    print('DELETE Request: $fullUrl');
    print('Headers: $headers');

    return _handleRequest<T>(
      request: http.delete(Uri.parse(fullUrl), headers: headers),
      fromJson: fromJson,
    );
  }
}