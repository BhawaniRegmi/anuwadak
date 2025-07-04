// horoscope_list_screen.dart
import 'package:flutter/material.dart';
import 'package:your_app_name/models/horoscope_model.dart'; // Adjust import based on your project structure

class HoroscopeListScreen extends StatefulWidget {
  const HoroscopeListScreen({super.key});

  @override
  State<HoroscopeListScreen> createState() => _HoroscopeListScreenState();
}

class _HoroscopeListScreenState extends State<HoroscopeListScreen> {
  // --- Data (acting as the "model" part's data source) ---
  final List<Horoscope> _horoscopes = [
    Horoscope(
      sign: 'Aries',
      dateRange: 'March 21 - April 19',
      prediction:
          'Aries, today brings new opportunities for growth. Embrace challenges with your usual courage.',
      imageUrl: 'https://via.placeholder.com/40?text=♈', // Placeholder image
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Horoscopes'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: _horoscopes.length,
        itemBuilder: (context, index) {
          final horoscope = _horoscopes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(horoscope.imageUrl),
                        radius: 20,
                      ),
                      const SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            horoscope.sign,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            horoscope.dateRange,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    horoscope.prediction,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}