import 'package:flutter/material.dart';
import '../models/job_profile.dart';
import '../controllers/job_profile_controller.dart';

class JobProfileDetailScreen extends StatefulWidget {
  final String jobProfileId;

  const JobProfileDetailScreen({Key? key, required this.jobProfileId}) : super(key: key);

  @override
  _JobProfileDetailScreenState createState() => _JobProfileDetailScreenState();
}

class _JobProfileDetailScreenState extends State<JobProfileDetailScreen> {
  late Future<JobProfile?> _jobProfileFuture;
  final JobProfileController _controller = JobProfileController();

  @override
  void initState() {
    super.initState();
    _jobProfileFuture = _controller.fetchJobProfileById(widget.jobProfileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Profile Details'),
      ),
      body: FutureBuilder<JobProfile?>(
        future: _jobProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final jobProfile = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobProfile.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    jobProfile.company,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    jobProfile.location,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const Divider(height: 30, thickness: 1),
                  _buildSectionTitle('Description'),
                  Text(
                    jobProfile.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Responsibilities'),
                  ...jobProfile.responsibilities.map((resp) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        child: Text('• $resp', style: const TextStyle(fontSize: 16)),
                      )),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Qualifications'),
                  ...jobProfile.qualifications.map((qual) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        child: Text('• $qual', style: const TextStyle(fontSize: 16)),
                      )),
                  const SizedBox(height: 16),
                  _buildInfoRow('Salary Range', jobProfile.salaryRange),
                  _buildInfoRow('Employment Type', jobProfile.employmentType),
                  _buildInfoRow('Application Deadline', jobProfile.applicationDeadline),
                  _buildInfoRow('Posted Date', jobProfile.postedDate),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Job Profile not found.'));
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}