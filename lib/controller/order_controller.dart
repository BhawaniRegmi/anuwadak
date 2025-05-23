import 'package:flutter/foundation.dart';
import 'package:your_app_name/models/order_model.dart'; // Adjust import path

class OrderController extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  OrderController() {
    fetchOrders(); // Fetch orders when the controller is initialized
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate fetching data from an API or database
      await Future.delayed(const Duration(seconds: 2));

      // Dummy data
      _orders = [
        Order(
          orderId: 'ORD001',
          orderDate: DateTime(2023, 10, 26, 10, 30),
          items: [
            OrderItem(id: 'ITEM001', name: 'Laptop', quantity: 1, price: 1200.00),
            OrderItem(id: 'ITEM002', name: 'Mouse', quantity: 1, price: 25.00),
          ],
          totalAmount: 1225.00,
          status: 'Delivered',
        ),
        Order(
          orderId: 'ORD002',
          orderDate: DateTime(2023, 10, 25, 14, 0),
          items: [
            OrderItem(id: 'ITEM003', name: 'Keyboard', quantity: 1, price: 75.00),
            OrderItem(id: 'ITEM004', name: 'Monitor', quantity: 1, price: 300.00),
          ],
          totalAmount: 375.00,
          status: 'Pending',
        ),
        Order(
          orderId: 'ORD003',
          orderDate: DateTime(2023, 10, 24, 9, 0),
          items: [
            OrderItem(id: 'ITEM005', name: 'Headphones', quantity: 2, price: 50.00),
          ],
          totalAmount: 100.00,
          status: 'Shipped',
        ),
      ];
    } catch (e) {
      _errorMessage = 'Failed to load orders: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Example of a function to update an order status (can be expanded)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    // Simulate API call to update status
    await Future.delayed(const Duration(seconds: 1));
    final index = _orders.indexWhere((order) => order.orderId == orderId);
    if (index != -1) {
      _orders[index] = Order(
        orderId: _orders[index].orderId,
        orderDate: _orders[index].orderDate,
        items: _orders[index].items,
        totalAmount: _orders[index].totalAmount,
        status: newStatus,
      );
      notifyListeners();
    }
  }
}