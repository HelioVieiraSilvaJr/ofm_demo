import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ofm_demo/Sorces/Constants.dart';

class NetworkResponse {
  final dynamic bodyResponse;
  final int statusCode;

  NetworkResponse({
    required this.bodyResponse,
    required this.statusCode,
  });
}

class NetworkNew {
  final String baseUrl;

  NetworkNew([String? url]) : baseUrl = url ?? kBaseURL;

  Map<String, String> _prepareHeaders(Map<String, String>? headers) {
    final Map<String, String> finalHeaders =
        headers != null ? Map<String, String>.from(headers) : {};

    if (!finalHeaders.containsKey('Content-Type')) {
      finalHeaders['Content-Type'] = 'application/json';
    }

    return finalHeaders;
  }

  Future<NetworkResponse> get(String endpoint,
      {Map<String, String>? params, Map<String, String>? headers}) async {
    final finalHeaders = _prepareHeaders(headers);
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint').replace(queryParameters: params),
      headers: finalHeaders,
    );
    return _buildResponse(response);
  }

  Future<NetworkResponse> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final finalHeaders = _prepareHeaders(headers);
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: finalHeaders,
      body: jsonEncode(body),
    );
    return _buildResponse(response);
  }

  Future<NetworkResponse> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final finalHeaders = _prepareHeaders(headers);
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: finalHeaders,
      body: jsonEncode(body),
    );
    return _buildResponse(response);
  }

  Future<NetworkResponse> delete(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final finalHeaders = _prepareHeaders(headers);
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: finalHeaders,
      body: jsonEncode(body),
    );
    return _buildResponse(response);
  }

  NetworkResponse _buildResponse(http.Response response) {
    dynamic decodedBody;
    try {
      decodedBody = jsonDecode(response.body);
    } catch (_) {
      decodedBody = response.body;
    }
    return NetworkResponse(
      bodyResponse: decodedBody,
      statusCode: response.statusCode,
    );
  }
}
