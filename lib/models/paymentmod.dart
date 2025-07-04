class PaymentDetails {
  final String cardNumber;
  final String expiryDate; // MM/YY
  final String cvv;
  final String cardHolderName;
  final double amount; // Assuming a fixed amount for simplicity

  PaymentDetails({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardHolderName,
    required this.amount,
  });

  // You might add methods here for serialization/deserialization if needed
  // e.g., to/from JSON for sending to a backend
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'cardHolderName': cardHolderName,
      'amount': amount,
    };
  }
}