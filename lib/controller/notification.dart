// lib/controllers/notification_controller.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/notification_model.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs

class NotificationController extends ChangeNotifier {
  List<Notification> _notifications = [];
  final Uuid _uuid = Uuid();

  // Constructor: Optionally load initial data
  NotificationController() {
    _loadNotifications();
  }

  // Public getter for notifications (read-only)
  List<Notification> get notifications => List.unmodifiable(_notifications);

  // --- Data Loading/Mocking (Replace with actual API calls/database) ---
  void _loadNotifications() {
    // Simulate fetching notifications from a database or API
    // In a real app, you'd use http, shared_preferences, or a local DB
    _notifications = [
      Notification(
        id: _uuid.v4(),
        title: 'Welcome to our App!',
        body: 'Thanks for signing up. Explore our features.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
      Notification(
        id: _uuid.v4(),
        title: 'New Message from Support',
        body: 'We\'ve responded to your recent inquiry.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      Notification(
        id: _uuid.v4(),
        title: 'Your Order #12345 Has Shipped!',
        body: 'Track your package using the link provided.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true, // Example of a read notification
      ),
      Notification(
        id: _uuid.v4(),
        title: 'Special Offer: 20% Off!',
        body: 'Don\'t miss out on our limited-time discount.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: false,
      ),
    ];
    // Sort notifications by timestamp (newest first)
    _notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    notifyListeners(); // Notify listeners after data is loaded
  }

  // --- Notification Management ---

  void addNotification(String title, String body) {
    final newNotification = Notification(
      id: _uuid.v4(),
      title: title,
      body: body,
      timestamp: DateTime.now(),
      isRead: false,
    );
    _notifications.insert(0, newNotification); // Add to the beginning
    notifyListeners(); // Notify the UI that data has changed
  }

  void markNotificationAsRead(String notificationId) {
    try {
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index].isRead = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  void markAllNotificationsAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }

  int get unreadCount {
    return _notifications.where((n) => !n.isRead).length;
  }

  // In a real application, you'd also have methods for:
  // - Fetching notifications from a remote API
  // - Persisting notifications locally (e.g., SQLite, shared preferences)
  // - Handling push notifications (Firebase Messaging)
}