// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer' as developer;

import 'package:adyen_checkout_example/config.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<Map<String, dynamic>> createSession(Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/sessions");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    final sessionResponse = jsonDecode(response.body);
    _log("Session id: ${sessionResponse["id"]}");
    return sessionResponse;
  }

  Future<Map<String, dynamic>> fetchPaymentMethods(
      Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/paymentMethods");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> postPayments(Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/payments");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");
    _log("PspReference: ${response.headers["pspreference"]}");

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> postPaymentsDetails(
      Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/payments/details");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    return jsonDecode(response.body);
  }

  Future<bool> deleteStoredPaymentMethod(
    String storedPaymentMethodId,
    Map<String, dynamic> queryParameters,
  ) async {
    final uri = Uri.https(
      Config.baseUrl,
      "/${Config.apiVersion}/storedPaymentMethods/$storedPaymentMethodId",
      queryParameters,
    );

    _log("=== API Request ===");
    _log("DELETE $uri");

    final response = await http.delete(
      uri,
      headers: _createHeaders(),
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> postPaymentMethodsBalance(
      Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/paymentMethods/balance");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> postOrders(Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/orders");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> postOrdersCancel(
      Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/orders/cancel");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> postCardDetails(
      Map<String, dynamic> body) async {
    final uri = Uri.https(Config.baseUrl, "/${Config.apiVersion}/cardDetails");
    final requestBody = jsonEncode(body);

    _log("=== API Request ===");
    _log("POST $uri");
    _log("Body: $requestBody");

    final response = await http.post(
      uri,
      headers: _createHeaders(),
      body: requestBody,
    );

    _log("=== API Response ===");
    _log("Status: ${response.statusCode}");
    _log("Body: ${response.body}");

    return jsonDecode(response.body);
  }

  Map<String, String> _createHeaders() => {
        "content-type": "application/json",
        "x-API-key": Config.xApiKey,
      };

  void _log(String message) {
    // Use developer.log for full messages without truncation
    developer.log(message, name: 'AdyenCheckout');
  }
}
