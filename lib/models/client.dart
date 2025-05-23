class Client {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final DateTime registrationDate;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.registrationDate,
  });

  // Optional: A factory constructor to create a Client from a JSON map (e.g., from an API)
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      company: json['company'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }

  // Optional: A method to convert a Client object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'registrationDate': registrationDate.toIso8601String(),
    };
  }
}