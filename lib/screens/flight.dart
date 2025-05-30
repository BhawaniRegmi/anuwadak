// lib/screens/flight_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/flight_controller.dart';
import '../models/flight_model.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2), // Allow picking up to 2 years in future
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _departureController,
              decoration: const InputDecoration(
                labelText: 'Departure City (e.g., New York, Kathmandu)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flight_takeoff),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination City (e.g., Los Angeles, Dubai)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flight_land),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Departure Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_departureController.text.isEmpty ||
                      _destinationController.text.isEmpty ||
                      _selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill all search criteria.')),
                    );
                    return;
                  }
                  Provider.of<FlightController>(context, listen: false)
                      .searchFlights(
                    departureCity: _departureController.text,
                    destinationCity: _destinationController.text,
                    departureDate: _selectedDate!,
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Search Flights'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<FlightController>(
                builder: (context, flightController, child) {
                  if (flightController.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (flightController.errorMessage != null) {
                    return Center(
                      child: Text(
                        flightController.errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (flightController.availableFlights.isNotEmpty) {
                    return ListView.builder(
                      itemCount: flightController.availableFlights.length,
                      itemBuilder: (context, index) {
                        final flight = flightController.availableFlights[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${flight.airline} - ${flight.flightNumber}',
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            flight.departureAirportCode,
                                            style: const TextStyle(
                                                fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            flight.departureCity,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                          Text(flight.formattedDepartureTime),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.arrow_right_alt, size: 40),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            flight.arrivalAirportCode,
                                            style: const TextStyle(
                                                fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            flight.arrivalCity,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                          Text(flight.formattedArrivalTime),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '\$${flight.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Enter your flight details to find flights.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}