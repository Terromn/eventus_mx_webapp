import 'package:http/http.dart' as http;
import 'dart:convert';

const String stripeSecretKey =
    'sk_test_51N1tDyEqpIDVxOfNQOOJ3RTW2TajJiGKIUh7GJycTeLHIwXhLxZRWeaYZ2TnzgZrS3xDyf9PikiNbBUFFZMdUEBg00tzBqhnkO';

Future<bool> verifyPaymentStatus(String paymentSessionId) async {
  final paymentIntentId = await getPaymentIntentId(paymentSessionId);
  if (paymentIntentId != null) {
    final paymentStatus = await getPaymentIntentStatus(paymentIntentId);
    if (paymentStatus == 'succeeded') {
      // Payment verification successful
      return true;
    } else {
      // Payment verification failed
      // ignore: avoid_print
      print('Payment verification failed. Status: $paymentStatus');
      return false;
    }
  } else {
    // ignore: avoid_print
    print('Failed to retrieve payment intent ID.');
    return false;
  }
}

Future<String?> getPaymentIntentId(String paymentSessionId) async {
  final url = 'https://api.stripe.com/v1/checkout/sessions/$paymentSessionId';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $stripeSecretKey',
    },
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final paymentIntentId = responseData['payment_intent'];
    return paymentIntentId;
  } else {
    // ignore: avoid_print
    print('Failed to fetch payment session details: ${response.statusCode}');
    return null;
  }
}

Future<String?> getPaymentIntentStatus(String paymentIntentId) async {
  final url = 'https://api.stripe.com/v1/payment_intents/$paymentIntentId';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $stripeSecretKey',
    },
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final paymentStatus = responseData['status'];
    return paymentStatus;
  } else {
    // ignore: avoid_print
    print('Failed to fetch payment intent details: ${response.statusCode}');
    return null;
  }
}

Future<String?> getProductName(String paymentSessionId) async {
  final paymentIntentId = await getPaymentIntentId(paymentSessionId);
  if (paymentIntentId != null) {
    final paymentDetails = await getPaymentIntentDetails(paymentIntentId);
    if (paymentDetails != null) {
      final productName = paymentDetails['productName'];
      return productName;
    } else {
      // Payment details not found
      // You can handle the error or return an appropriate value
      return null;
    }
  } else {
    // Payment intent ID not found
    // You can handle the error or return an appropriate value
    return null;
  }
}

Future<Map<String, dynamic>?> getPaymentIntentDetails(
    String paymentIntentId) async {
  final url = 'https://api.stripe.com/v1/payment_intents/$paymentIntentId';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $stripeSecretKey',
    },
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final paymentStatus = responseData['status'];
    final productName = responseData[
        'description']; // Assuming the product name is stored in the 'description' field
    return {
      'status': paymentStatus,
      'productName': productName,
    };
  } else {
    // ignore: avoid_print
    print('Failed to fetch payment intent details: ${response.statusCode}');
    return null;
  }
}
