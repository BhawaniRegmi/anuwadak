// horoscope_model.dart
class Horoscope {
  final String sign;
  final String dateRange;
  final String prediction;
  final String imageUrl; // Optional: for an icon or image

  Horoscope({
    required this.sign,
    required this.dateRange,
    required this.prediction,
    required this.imageUrl,
  });
}