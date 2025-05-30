import 'package:flutter/material.dart';
import 'package:your_app_name/models/promo_model.dart'; // Adjust import path

class PromoController extends ChangeNotifier {
  List<PromoModel> _promos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PromoModel> get promos => _promos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  PromoController() {
    fetchPromos(); // Fetch promos when the controller is initialized
  }

  Future<void> fetchPromos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate fetching data from an API
      await Future.delayed(const Duration(seconds: 2));

      // Example dummy data
      _promos = [
        PromoModel(
          id: 'promo_001',
          title: 'Special Discount!',
          description: 'Get 20% off on all electronics this week.',
          imageUrl: 'https://via.placeholder.com/400x200/FF5733/FFFFFF?text=Discount',
          callToAction: 'Shop Now',
          deepLink: 'app://products/electronics',
        ),
        PromoModel(
          id: 'promo_002',
          title: 'New User Bonus',
          description: 'Sign up today and get a \$10 welcome bonus!',
          imageUrl: 'https://via.placeholder.com/400x200/3366FF/FFFFFF?text=Welcome+Bonus',
          callToAction: 'Register',
          deepLink: 'app://auth/register',
        ),
        PromoModel(
          id: 'promo_003',
          title: 'Free Shipping',
          description: 'Enjoy free shipping on all orders over \$50.',
          imageUrl: 'https://via.placeholder.com/400x200/33CC66/FFFFFF?text=Free+Shipping',
          callToAction: 'View Details',
        ),
      ];
    } catch (e) {
      _errorMessage = 'Failed to load promos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Example of a method to handle promo tap (e.g., navigate to a deep link)
  void onPromoTap(PromoModel promo) {
    if (promo.deepLink != null) {
      // In a real app, you would use a package like `url_launcher`
      // or your own navigation logic to handle the deep link.
      debugPrint('Navigating to deep link: ${promo.deepLink}');
      // Example: launch(promo.deepLink!);
    } else {
      debugPrint('Promo tapped: ${promo.title} (No deep link)');
      // Handle navigation to a generic promo detail screen or similar.
    }
    // You might also want to log an analytic event here.
  }
}