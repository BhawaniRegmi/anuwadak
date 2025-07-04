class Contact {
  final String name;
  final String phoneNumber;
  final String? email; // Optional email
  final String? address; // Optional address

  Contact({
    required this.name,
    required this.phoneNumber,
    this.email,
    this.address,
  });
}