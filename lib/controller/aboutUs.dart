// lib/controllers/about_us_controller.dart
import 'package:flutter/foundation.dart';
import '../models/about_us_model.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs and emails

class AboutUsController extends ChangeNotifier {
  AboutUsModel? _aboutUsData;
  bool _isLoading = false;
  String? _errorMessage;

  AboutUsModel? get aboutUsData => _aboutUsData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AboutUsController() {
    _fetchAboutUsData(); // Fetch data when the controller is initialized
  }

  Future<void> _fetchAboutUsData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate fetching data from a server or local storage
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

      _aboutUsData = AboutUsModel(
        appName: 'My Awesome App',
        appVersion: '1.0.0',
        companyName: 'Tech Solutions Inc.',
        websiteUrl: 'https://www.techsolutions.com',
        contactEmail: 'contact@techsolutions.com',
        description:
            'My Awesome App is designed to simplify your daily tasks and enhance your productivity. We are committed to providing a seamless and enjoyable user experience.',
        teamMembers: [
          'Alice Smith (Lead Developer)',
          'Bob Johnson (UI/UX Designer)',
          'Charlie Brown (Marketing Specialist)',
        ],
      );
    } catch (e) {
      _errorMessage = 'Failed to load About Us data: $e';
      debugPrint('Error fetching About Us data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Action methods
  Future<void> launchWebsite() async {
    if (_aboutUsData != null && _aboutUsData!.websiteUrl.isNotEmpty) {
      final Uri url = Uri.parse(_aboutUsData!.websiteUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // Handle error (e.g., show a SnackBar)
        debugPrint('Could not launch $_aboutUsData!.websiteUrl');
      }
    }
  }

  Future<void> sendEmail() async {
    if (_aboutUsData != null && _aboutUsData!.contactEmail.isNotEmpty) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: _aboutUsData!.contactEmail,
        queryParameters: {'subject': 'About My Awesome App'},
      );
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        // Handle error
        debugPrint('Could not launch email to $_aboutUsData!.contactEmail');
      }
    }
  }
}