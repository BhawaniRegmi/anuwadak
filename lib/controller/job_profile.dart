import '../models/job_profile.dart';

class JobProfileController {
  // --- Dummy Data (Replace with actual API calls) ---
  List<JobProfile> _jobProfiles = [
    JobProfile(
      id: 'jp001',
      title: 'Senior Flutter Developer',
      company: 'Tech Solutions Inc.',
      location: 'New York, USA',
      description: 'We are looking for a highly skilled Senior Flutter Developer to join our dynamic team...',
      responsibilities: [
        'Develop and maintain high-quality Flutter applications.',
        'Collaborate with cross-functional teams to define, design, and ship new features.',
        'Ensure the performance, quality, and responsiveness of applications.',
        'Participate in code reviews and contribute to team best practices.',
      ],
      qualifications: [
        '5+ years of experience in mobile app development.',
        '3+ years of experience with Flutter.',
        'Strong understanding of Dart programming language.',
        'Experience with state management solutions (e.g., Provider, BLoC, GetX).',
        'Familiarity with RESTful APIs and asynchronous programming.',
      ],
      salaryRange: '\$100,000 - \$130,000 per year',
      employmentType: 'Full-time',
      applicationDeadline: '2025-07-15',
      postedDate: '2025-06-01',
    ),
    JobProfile(
      id: 'jp002',
      title: 'UI/UX Designer',
      company: 'Creative Hub Ltd.',
      location: 'London, UK',
      description: 'Join our creative team as a UI/UX Designer and help us craft intuitive and beautiful user experiences.',
      responsibilities: [
        'Design user interfaces and user experiences for mobile and web applications.',
        'Conduct user research and usability testing.',
        'Create wireframes, prototypes, and high-fidelity mockups.',
        'Collaborate with developers to ensure design implementation accuracy.',
      ],
      qualifications: [
        '3+ years of experience in UI/UX design.',
        'Proficiency with design tools like Figma, Sketch, or Adobe XD.',
        'Strong portfolio showcasing your design work.',
        'Understanding of user-centered design principles.',
      ],
      salaryRange: '\$60,000 - \$80,000 per year',
      employmentType: 'Full-time',
      applicationDeadline: '2025-07-20',
      postedDate: '2025-05-28',
    ),
  ];
  // --- End Dummy Data ---

  // Fetches all job profiles
  Future<List<JobProfile>> fetchAllJobProfiles() async {
    // Simulate a network delay
    await Future.delayed(Duration(seconds: 1));
    return _jobProfiles;
  }

  // Fetches a single job profile by ID
  Future<JobProfile?> fetchJobProfileById(String id) async {
    // Simulate a network delay
    await Future.delayed(Duration(seconds: 0));
    try {
      return _jobProfiles.firstWhere((profile) => profile.id == id);
    } catch (e) {
      return null; // Job profile not found
    }
  }

  // Adds a new job profile
  Future<void> addJobProfile(JobProfile newProfile) async {
    // Simulate API call to add a profile
    await Future.delayed(Duration(milliseconds: 500));
    _jobProfiles.add(newProfile);
    print('Job Profile added: ${newProfile.title}');
  }

  // Updates an existing job profile
  Future<bool> updateJobProfile(JobProfile updatedProfile) async {
    // Simulate API call to update a profile
    await Future.delayed(Duration(milliseconds: 500));
    int index = _jobProfiles.indexWhere((profile) => profile.id == updatedProfile.id);
    if (index != -1) {
      _jobProfiles[index] = updatedProfile;
      print('Job Profile updated: ${updatedProfile.title}');
      return true;
    }
    print('Job Profile not found for update: ${updatedProfile.id}');
    return false;
  }

  // Deletes a job profile by ID
  Future<bool> deleteJobProfile(String id) async {
    // Simulate API call to delete a profile
    await Future.delayed(Duration(milliseconds: 500));
    final initialLength = _jobProfiles.length;
    _jobProfiles.removeWhere((profile) => profile.id == id);
    if (_jobProfiles.length < initialLength) {
      print('Job Profile deleted: $id');
      return true;
    }
    print('Job Profile not found for deletion: $id');
    return false;
  }
}