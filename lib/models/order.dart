class OrderItem {
  final String id;
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Order {
  final String orderId;
  final DateTime orderDate;
  final List<OrderItem> items;
  final double totalAmount;
  final String status; // e.g., 'Pending', 'Confirmed', 'Shipped', 'Delivered'

  Order({
    required this.orderId,
    required this.orderDate,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}