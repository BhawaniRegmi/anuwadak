// horoscope_controller.dart
import 'package:flutter/foundation.dart';
import 'package:your_app_name/models/horoscope_model.dart'; // Adjust import

class HoroscopeController extends ChangeNotifier {
  List<Horoscope> _horoscopes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Horoscope> get horoscopes => _horoscopes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  HoroscopeController() {
    fetchHoroscopes(); // Fetch data when the controller is created
  }

  Future<void> fetchHoroscopes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started

    // Simulate network delay and data fetching
    await Future.delayed(const Duration(seconds: 2));

    try {
      // In a real app, you would make an HTTP request here
      // Example: final response = await http.get(Uri.parse('your_api_endpoint'));
      // final List<dynamic> data = json.decode(response.body);
      // _horoscopes = data.map((json) => Horoscope.fromJson(json)).toList();

      // Static data for demonstration
      _horoscopes = [
        Horoscope(
          sign: 'Aries',
          dateRange: 'March 21 - April 19',
          prediction:
              'Aries, today brings new opportunities for growth. Embrace challenges with your usual courage.',
          imageUrl: 'https://via.placeholder.com/40?text=♈',
        ),
        Horoscope(
          sign: 'Taurus',
          dateRange: 'April 20 - May 20',
          prediction:
              'Taurus, focus on stability and comfort. Good news regarding finances may be on the horizon.',
          imageUrl: 'https://via.placeholder.com/40?text=♉',
        ),
        Horoscope(
          sign: 'Gemini',
          dateRange: 'May 21 - June 20',
          prediction:
              'Gemini, communication is key today. Express your thoughts clearly to avoid misunderstandings.',
          imageUrl: 'https://via.placeholder.com/40?text=♊',
        ),
        Horoscope(
          sign: 'Cancer',
          dateRange: 'June 21 - July 22',
          prediction:
              'Cancer, nurture your emotional well-being. A quiet day at home could be just what you need.',
          imageUrl: 'https://via.placeholder.com/40?text=♋',
        ),
        Horoscope(
          sign: 'Leo',
          dateRange: 'July 23 - August 22',
          prediction:
              'Leo, your creativity is soaring. Share your ideas and let your leadership shine.',
          imageUrl: 'https://via.placeholder.com/40?text=♌',
        ),
        Horoscope(
          sign: 'Virgo',
          dateRange: 'August 23 - September 22',
          prediction:
              'Virgo, pay attention to details. Organizing your tasks will bring a sense of accomplishment.',
          imageUrl: 'https://via.placeholder.com/40?text=♍',
        ),
        Horoscope(
          sign: 'Libra',
          dateRange: 'September 23 - October 22',
          prediction:
              'Libra, seek balance in your relationships. Diplomacy will help you navigate any conflicts.',
          imageUrl: 'https://via.placeholder.com/40?text=♎',
        ),
        Horoscope(
          sign: 'Scorpio',
          dateRange: 'October 23 - November 21',
          prediction:
              'Scorpio, your intuition is strong. Trust your gut feelings in important decisions.',
          imageUrl: 'https://via.placeholder.com/40?text=♏',
        ),
        Horoscope(
          sign: 'Sagittarius',
          dateRange: 'November 22 - December 21',
          prediction:
              'Sagittarius, an adventurous spirit will guide you. Explore new ideas and places.',
          imageUrl: 'https://via.placeholder.com/40?text=♐',
        ),
        Horoscope(
          sign: 'Capricorn',
          dateRange: 'December 22 - January 19',
          prediction:
              'Capricorn, hard work pays off. Your dedication will lead to tangible results.',
          imageUrl: 'https://via.placeholder.com/40?text=♑',
        ),
        Horoscope(
          sign: 'Aquarius',
          dateRange: 'January 20 - February 18',
          prediction:
              'Aquarius, innovative ideas come to light. Connect with like-minded individuals.',
          imageUrl: 'https://via.placeholder.com/40?text=♒',
        ),
        Horoscope(
          sign: 'Pisces',
          dateRange: 'February 19 - March 20',
          prediction:
              'Pisces, empathy and compassion are your strengths today. Offer support to those around you.',
          imageUrl: 'https://via.placeholder.com/40?text=♓',
        ),
      ];
    } catch (e) {
      _errorMessage = 'Failed to load horoscopes: $e';
      debugPrint('Error fetching horoscopes: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has finished (or error occurred)
    }
  }
}