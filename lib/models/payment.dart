class Payment {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final PaymentStatus status; // Enum for status

  Payment({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
  });

  // Factory constructor for creating a Payment object from a Map (e.g., from JSON)
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(), // Handle int/double from JSON
      date: DateTime.parse(json['date']),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => PaymentStatus.pending, // Default if not found
      ),
    );
  }

  // Method to convert a Payment object to a Map (e.g., for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(), // ISO 8601 string for dates
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }
}

enum PaymentStatus {
  completed,
  pending,
  failed,
  refunded,
}