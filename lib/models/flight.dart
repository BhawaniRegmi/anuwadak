// lib/models/flight_model.dart

class FlightModel {
  final String flightNumber;
  final String airline;
  final String departureAirportCode;
  final String departureCity;
  final DateTime departureTime;
  final String arrivalAirportCode;
  final String arrivalCity;
  final DateTime arrivalTime;
  final double price;

  FlightModel({
    required this.flightNumber,
    required this.airline,
    required this.departureAirportCode,
    required this.departureCity,
    required this.departureTime,
    required this.arrivalAirportCode,
    required this.arrivalCity,
    required this.arrivalTime,
    required this.price,
  });

  // Helper to format time for display
  String get formattedDepartureTime {
    return '${departureTime.hour.toString().padLeft(2, '0')}:${departureTime.minute.toString().padLeft(2, '0')}';
  }

  String get formattedArrivalTime {
    return '${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}';
  }

  String get formattedDepartureDate {
    return '${departureTime.day}/${departureTime.month}/${departureTime.year}';
  }

  String get formattedArrivalDate {
    return '${arrivalTime.day}/${arrivalTime.month}/${arrivalTime.year}';
  }

  // You could add a factory constructor here for parsing JSON if from an API
  // factory FlightModel.fromJson(Map<String, dynamic> json) { ... }
}