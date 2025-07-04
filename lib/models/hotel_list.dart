class Hotel {
  final String id;
  final String name;
  final String imageUrl;
  final String location;
  final double rating;
  final String priceRange; // e.g., "$100 - $200"

  Hotel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.priceRange,
  });

  // Factory constructor to create a Hotel object from a JSON map
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      rating: json['rating'].toDouble(),
      priceRange: json['priceRange'],
    );
  }

  // Method to convert a Hotel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'rating': rating,
      'priceRange': priceRange,
    };
  }
}