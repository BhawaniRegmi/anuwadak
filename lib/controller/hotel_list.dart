import 'package:flutter/foundation.dart';
import '../models/hotel.dart';

class HotelController extends ChangeNotifier {
  List<Hotel> _hotels = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Hotel> get hotels => _hotels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  HotelController() {
    fetchHotels(); // Fetch hotels when the controller is initialized
  }

  Future<void> fetchHotels() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started

    try {
      // Simulate fetching data from an API or database
      await Future.delayed(const Duration(seconds: 2));

      // Sample data
      _hotels = [
        Hotel(
          id: 'h1',
          name: 'Grand Hyatt Kathmandu',
          imageUrl: 'https://images.unsplash.com/photo-1549294413-26f19527f05c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          location: 'Kathmandu, Nepal',
          rating: 4.8,
          priceRange: '\$150 - \$300',
        ),
        Hotel(
          id: 'h2',
          name: 'Soaltee Crowne Plaza',
          imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          location: 'Kathmandu, Nepal',
          rating: 4.5,
          priceRange: '\$120 - \$250',
        ),
        Hotel(
          id: 'h3',
          name: 'Hotel Shanker',
          imageUrl: 'https://images.unsplash.com/photo-1582719478250-c8dbe48f2252?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          location: 'Kathmandu, Nepal',
          rating: 4.2,
          priceRange: '\$80 - \$180',
        ),
        Hotel(
          id: 'h4',
          name: 'The Dwarika\'s Hotel',
          imageUrl: 'https://images.unsplash.com/photo-1551882575-ed5240214a1e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          location: 'Kathmandu, Nepal',
          rating: 4.9,
          priceRange: '\$200 - \$500',
        ),
      ];
    } catch (e) {
      _errorMessage = 'Failed to load hotels: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has finished
    }
  }
}