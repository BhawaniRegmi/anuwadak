import 'package:flutter/foundation.dart';
import 'package:your_app_name/models/announcement_model.dart'; // Adjust path as needed

class AnnouncementController extends ChangeNotifier {
  List<Announcement> _announcements = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Announcement> get announcements => _announcements;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAnnouncements() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call or data fetching
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      // Dummy data - replace with your actual data fetching logic
      _announcements = [
        Announcement(
          id: '1',
          title: 'Important System Maintenance',
          description: 'Our system will undergo scheduled maintenance on July 1st, 2025, from 10 PM to 2 AM UTC. Services may be temporarily unavailable during this period.',
          date: DateTime(2025, 6, 10, 10, 0),
        ),
        Announcement(
          id: '2',
          title: 'New Feature Release: Dark Mode',
          description: 'We are excited to announce the release of Dark Mode! You can now switch to a darker theme in your settings for a more comfortable viewing experience.',
          date: DateTime(2025, 6, 8, 14, 30),
        ),
        Announcement(
          id: '3',
          title: 'Upcoming Webinar: "Mastering Flutter"',
          description: 'Join our free webinar on July 15th, 2025, to learn advanced Flutter techniques. Register now to reserve your spot!',
          date: DateTime(2025, 6, 5, 9, 0),
        ),
      ];

      _errorMessage = null; // Clear any previous errors
    } catch (e) {
      _errorMessage = 'Failed to load announcements: $e';
      _announcements = []; // Clear announcements on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // You can add more methods here for other announcement-related operations
  // e.g., addAnnouncement, deleteAnnouncement, updateAnnouncement
}