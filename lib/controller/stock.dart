import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import 'dart:math'; // For simulating random price changes

class StockController extends ChangeNotifier {
  List<Stock> _stocks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Stock> get stocks => _stocks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  StockController() {
    fetchStocks(); // Fetch data when the controller is initialized
  }

  Future<void> fetchStocks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify UI that loading has started

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // --- SIMULATED STOCK DATA ---
      // In a real app, this would be an actual API call to a stock data provider.
      final List<Map<String, dynamic>> rawStockData = [
        {
          "symbol": "AAPL",
          "companyName": "Apple Inc.",
          "currentPrice": 170.00,
          "priceChange": 1.50,
          "changePercentage": 0.89,
        },
        {
          "symbol": "GOOGL",
          "companyName": "Alphabet Inc. (Class A)",
          "currentPrice": 180.25,
          "priceChange": -2.10,
          "changePercentage": -1.15,
        },
        {
          "symbol": "MSFT",
          "companyName": "Microsoft Corp.",
          "currentPrice": 420.50,
          "priceChange": 3.25,
          "changePercentage": 0.78,
        },
        {
          "symbol": "AMZN",
          "companyName": "Amazon.com Inc.",
          "currentPrice": 190.75,
          "priceChange": -0.80,
          "changePercentage": -0.42,
        },
        {
          "symbol": "TSLA",
          "companyName": "Tesla Inc.",
          "currentPrice": 175.30,
          "priceChange": 5.10,
          "changePercentage": 2.99,
        },
      ];

      // Simulate a small update to prices to show reactivity
      final random = Random();
      _stocks = rawStockData.map((data) {
        double currentPrice = (data['currentPrice'] as num).toDouble();
        double newPriceChange = (random.nextDouble() * 5.0 - 2.5); // -2.5 to +2.5
        double newCurrentPrice = currentPrice + newPriceChange;
        double newChangePercentage = (newPriceChange / currentPrice) * 100;

        return Stock(
          symbol: data['symbol'] as String,
          companyName: data['companyName'] as String,
          currentPrice: newCurrentPrice,
          priceChange: newPriceChange,
          changePercentage: newChangePercentage,
        );
      }).toList();

    } catch (e) {
      _errorMessage = 'Failed to fetch stocks: ${e.toString()}';
      debugPrint('Error fetching stocks: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI that loading has finished or error occurred
    }
  }

  // You might add methods for searching, filtering, etc.
  // void searchStocks(String query) {
  //   // Logic to filter _stocks based on query
  //   notifyListeners();
  // }
}