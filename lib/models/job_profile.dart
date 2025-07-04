class JobProfile {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final List<String> responsibilities;
  final List<String> qualifications;
  final String salaryRange;
  final String employmentType; // e.g., Full-time, Part-time, Contract
  final String applicationDeadline;
  final String postedDate;

  JobProfile({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.responsibilities,
    required this.qualifications,
    required this.salaryRange,
    required this.employmentType,
    required this.applicationDeadline,
    required this.postedDate,
  });

  // Factory constructor to create a JobProfile from a Map (e.g., from JSON)
  factory JobProfile.fromJson(Map<String, dynamic> json) {
    return JobProfile(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      responsibilities: List<String>.from(json['responsibilities'] as List),
      qualifications: List<String>.from(json['qualifications'] as List),
      salaryRange: json['salaryRange'] as String,
      employmentType: json['employmentType'] as String,
      applicationDeadline: json['applicationDeadline'] as String,
      postedDate: json['postedDate'] as String,
    );
  }

  // Method to convert a JobProfile to a Map (e.g., for sending to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'responsibilities': responsibilities,
      'qualifications': qualifications,
      'salaryRange': salaryRange,
      'employmentType': employmentType,
      'applicationDeadline': applicationDeadline,
      'postedDate': postedDate,
    };
  }
}