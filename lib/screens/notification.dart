// lib/screens/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/notification_controller.dart';
import 'package:flutter_app/models/notification_model.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Consumer<NotificationController>(
            builder: (context, controller, child) {
              if (controller.unreadCount > 0) {
                return TextButton(
                  onPressed: () {
                    controller.markAllNotificationsAsRead();
                  },
                  child: const Text(
                    'Mark All Read',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return const SizedBox.shrink(); // Hide button if no unread
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Example: Add a new notification
              Provider.of<NotificationController>(context, listen: false)
                  .addNotification('New Alert!', 'This is a test notification.');
            },
          ),
        ],
      ),
      body: Consumer<NotificationController>(
        builder: (context, controller, child) {
          if (controller.notifications.isEmpty) {
            return const Center(
              child: Text('No notifications yet!'),
            );
          }
          return ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              return NotificationTile(
                notification: notification,
                onTap: () {
                  controller.markNotificationAsRead(notification.id);
                  // Optionally navigate to a detail screen
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationDetailScreen(notification: notification)));
                },
                onDismissed: (direction) {
                  controller.deleteNotification(notification.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification "${notification.title}" dismissed.'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example of adding a new notification
          Provider.of<NotificationController>(context, listen: false)
              .addNotification('Reminder!', 'Don\'t forget your meeting at 3 PM.');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final Notification notification;
  final VoidCallback onTap;
  final DismissDirectionCallback onDismissed;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id), // Unique key for Dismissible
      direction: DismissDirection.endToStart, // Only allow swipe from right to left
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: onDismissed,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: notification.isRead ? Colors.grey[100] : Colors.white,
        elevation: notification.isRead ? 0.5 : 2,
        child: ListTile(
          leading: Icon(
            notification.isRead ? Icons.notifications_none : Icons.notifications_active,
            color: notification.isRead ? Colors.grey : Colors.blue,
          ),
          title: Text(
            notification.title,
            style: TextStyle(
              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: notification.isRead ? Colors.grey[700] : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('MMM dd, yyyy - hh:mm a').format(notification.timestamp),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          trailing: notification.isRead ? null : const Icon(Icons.circle, color: Colors.blue, size: 10),
          onTap: onTap,
        ),
      ),
    );
  }
}