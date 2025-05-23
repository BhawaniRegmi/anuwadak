import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // For @required if not using null safety
import 'package:http/http.dart' as http; // For simulating API calls
import 'dart:convert'; // For JSON encoding/decoding

import '../model/payment.dart'; // Import your Payment model

class PaymentHistoryController extends ChangeNotifier {
  List<Payment> _payments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Payment> get payments => _payments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  PaymentHistoryController() {
    fetchPaymentHistory(); // Fetch data when the controller is initialized
  }

  Future<void> fetchPaymentHistory() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started

    try {
      // Simulate API call
      // In a real app, you would make an actual HTTP request here:
      // final response = await http.get(Uri.parse('https://api.yourdomain.com/payment_history'));
      // if (response.statusCode == 200) {
      //   List<dynamic> jsonList = json.decode(response.body);
      //   _payments = jsonList.map((json) => Payment.fromJson(json)).toList();
      // } else {
      //   _errorMessage = 'Failed to load payment history: ${response.statusCode}';
      // }

      // --- Simulated Data (for demonstration) ---
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      final List<Map<String, dynamic>> dummyData = [
        {
          'id': 'P001',
          'description': 'Online Purchase - T-Shirt',
          'amount': 25.99,
          'date': '2023-05-10T10:30:00Z',
          'status': 'completed',
        },
        {
          'id': 'P002',
          'description': 'Electricity Bill',
          'amount': 55.50,
          'date': '2023-05-08T15:00:00Z',
          'status': 'completed',
        },
        {
          'id': 'P003',
          'description': 'Subscription Renewal',
          'amount': 9.99,
          'date': '2023-05-05T09:00:00Z',
          'status': 'pending',
        },
        {
          'id': 'P004',
          'description': 'Refund for damaged item',
          'amount': 15.00,
          'date': '2023-05-02T11:45:00Z',
          'status': 'refunded',
        },
        {
          'id': 'P005',
          'description': 'Failed transaction - Wallet Top-up',
          'amount': 100.00,
          'date': '2023-04-28T18:00:00Z',
          'status': 'failed',
        },
      ];
      _payments = dummyData.map((json) => Payment.fromJson(json)).toList();
      // ----------------------------------------

    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print('Error fetching payment history: $e'); // Log the error
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has finished (or error occurred)
    }
  }

  // You can add more business logic here, e.g., filtering, sorting, etc.
  List<Payment> getCompletedPayments() {
    return _payments.where((payment) => payment.status == PaymentStatus.completed).toList();
  }

  List<Payment> getPendingPayments() {
    return _payments.where((payment) => payment.status == PaymentStatus.pending).toList();
  }
}