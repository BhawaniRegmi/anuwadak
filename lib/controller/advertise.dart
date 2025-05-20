import 'package:flutter/material.dart';
import 'package:flutter_advertisement_example/models/ad_model.dart';
import 'package:flutter_advertisement_example/repositories/ad_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class AdController extends ChangeNotifier {
  final AdRepository _adRepository;
  AdModel? _currentAd;
  bool _isLoading = false;
  String? _errorMessage;

  AdController(this._adRepository);

  AdModel? get currentAd => _currentAd;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAd() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentAd = await _adRepository.fetchAd();
    } catch (e) {
      _errorMessage = 'Failed to load ad: $e';
      _currentAd = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> openAdLink() async {
    if (_currentAd != null && await canLaunchUrl(Uri.parse(_currentAd!.clickUrl))) {
      await launchUrl(Uri.parse(_currentAd!.clickUrl));
    } else {
      // Handle the case where the URL cannot be launched
      print('Could not launch ${_currentAd?.clickUrl}');
    }
  }
}