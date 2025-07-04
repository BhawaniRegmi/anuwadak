import 'package:flutter/material.dart';
import '../models/payment_details.dart';

class PaymentController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();

  bool _isLoading = false;
  String? _paymentStatusMessage;

  bool get isLoading => _isLoading;
  String? get paymentStatusMessage => _paymentStatusMessage;

  // For simplicity, let's assume a fixed amount to pay
  final double amountToPay = 99.99;

  void disposeControllers() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardHolderNameController.dispose();
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    // Basic Luhn algorithm check (simplified for example)
    // A real implementation would use a proper library or backend validation
    if (value.replaceAll(' ', '').length < 13 || value.replaceAll(' ', '').length > 19) {
      return 'Invalid card number length';
    }
    // You might add more sophisticated regex or luhn algorithm here
    return null;
  }

  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }
    final parts = value.split('/');
    if (parts.length != 2) {
      return 'Format MM/YY';
    }
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null || month < 1 || month > 12) {
      return 'Invalid month';
    }

    final currentYear = DateTime.now().year % 100; // Get last two digits of current year
    final currentMonth = DateTime.now().month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Card has expired';
    }
    return null;
  }

  String? validateCvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    if (value.length < 3 || value.length > 4) {
      return 'Invalid CVV';
    }
    return null;
  }

  String? validateCardHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card holder name is required';
    }
    return null;
  }

  Future<void> processPayment() async {
    if (!formKey.currentState!.validate()) {
      _paymentStatusMessage = 'Please correct the errors in the form.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _paymentStatusMessage = null;
    notifyListeners();

    final paymentDetails = PaymentDetails(
      cardNumber: cardNumberController.text.replaceAll(' ', ''),
      expiryDate: expiryDateController.text,
      cvv: cvvController.text,
      cardHolderName: cardHolderNameController.text,
      amount: amountToPay,
    );

    // --- SIMULATED PAYMENT GATEWAY INTERACTION ---
    // In a real application, you would send `paymentDetails` (or a tokenized version)
    // to your backend, which then communicates with the actual payment gateway (Stripe, PayPal, etc.).
    // NEVER send raw card details directly from the client to a third-party gateway unless
    // you are using their SDK's tokenization features securely.

    print('Processing payment with details: ${paymentDetails.toJson()}');

    await Future.delayed(const Duration(seconds: 3)); // Simulate network delay

    // Simulate payment success or failure
    final bool paymentSuccessful = DateTime.now().second % 2 == 0; // Random success/failure

    if (paymentSuccessful) {
      _paymentStatusMessage = 'Payment successful! Thank you.';
      // Clear fields on successful payment
      cardNumberController.clear();
      expiryDateController.clear();
      cvvController.clear();
      cardHolderNameController.clear();
    } else {
      _paymentStatusMessage = 'Payment failed. Please try again or use a different card.';
    }

    _isLoading = false;
    notifyListeners();
  }
}