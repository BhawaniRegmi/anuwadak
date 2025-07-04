// cv_model.dart

class Education {
  final String degree;
  final String university;
  final String graduationYear;

  Education({
    required this.degree,
    required this.university,
    required this.graduationYear,
  });
}

class Experience {
  final String jobTitle;
  final String company;
  final String startDate;
  final String? endDate; // Nullable for current job
  final String description;

  Experience({
    required this.jobTitle,
    required this.company,
    required this.startDate,
    this.endDate,
    required this.description,
  });
}

class CV {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String professionalSummary;
  final List<Education> education;
  final List<Experience> experience;
  final List<String> skills;

  CV({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.professionalSummary,
    required this.education,
    required this.experience,
    required this.skills,
  });

  // A simple factory constructor for dummy data
  factory CV.dummy() {
    return CV(
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 (555) 123-4567',
      address: '123 Main St, Anytown, USA',
      professionalSummary:
          'Highly motivated software engineer with 5+ years of experience in mobile application development. Proficient in Flutter, Dart, and various mobile technologies. Seeking to leverage strong technical skills and problem-solving abilities to contribute to innovative projects.',
      education: [
        Education(
          degree: 'Master of Science in Computer Science',
          university: 'University of Tech',
          graduationYear: '2020',
        ),
        Education(
          degree: 'Bachelor of Science in Software Engineering',
          university: 'State University',
          graduationYear: '2018',
        ),
      ],
      experience: [
        Experience(
          jobTitle: 'Senior Flutter Developer',
          company: 'Mobile Solutions Inc.',
          startDate: 'Jan 2023',
          endDate: null, // Current job
          description:
              'Led the development of several high-performance Flutter applications. Implemented new features, optimized existing code, and mentored junior developers. Collaborated with UI/UX designers to ensure excellent user experience.',
        ),
        Experience(
          jobTitle: 'Flutter Developer',
          company: 'App Innovators LLC',
          startDate: 'Mar 2020',
          endDate: 'Dec 2022',
          description:
              'Developed and maintained cross-platform mobile applications using Flutter. Integrated various APIs and third-party libraries. Participated in code reviews and agile development sprints.',
        ),
      ],
      skills: [
        'Flutter',
        'Dart',
        'Mobile Development',
        'Firebase',
        'RESTful APIs',
        'Git',
        'Agile Methodologies',
        'UI/UX Design',
      ],
    );
  }
}