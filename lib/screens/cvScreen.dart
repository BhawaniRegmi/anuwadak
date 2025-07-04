// job_cv_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cv_controller.dart';
import 'cv_model.dart';

class JobCvScreen extends StatelessWidget {
  const JobCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We use ChangeNotifierProvider to provide the CvController to its descendants.
    // This is typically done higher up in the widget tree (e.g., in main.dart)
    // but for a standalone example, we'll put it here.
    return ChangeNotifierProvider(
      create: (context) => CvController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Job CV'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Consumer<CvController>(
          // Consumer rebuilds its children whenever notifyListeners() is called in CvController.
          builder: (context, controller, child) {
            final cv = controller.cv;

            if (cv == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(cv),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Professional Summary'),
                  _buildProfessionalSummary(context, cv, controller),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Education'),
                  _buildEducationList(cv.education),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Experience'),
                  _buildExperienceList(cv.experience),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Skills'),
                  _buildSkillsList(cv.skills),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(CV cv) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cv.fullName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Email: ${cv.email}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Phone: ${cv.phoneNumber}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Address: ${cv.address}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildProfessionalSummary(
      BuildContext context, CV cv, CvController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cv.professionalSummary,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () {
              // Example of how you might trigger an update
              _showEditSummaryDialog(context, controller, cv.professionalSummary);
            },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('Edit Summary'),
          ),
        ),
      ],
    );
  }

  void _showEditSummaryDialog(
      BuildContext context, CvController controller, String currentSummary) {
    final TextEditingController textController =
        TextEditingController(text: currentSummary);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Edit Professional Summary'),
          content: TextField(
            controller: textController,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your professional summary',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                controller.updateProfessionalSummary(textController.text);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEducationList(List<Education> education) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: education
          .map(
            (edu) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.degree,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      edu.university,
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Graduation: ${edu.graduationYear}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildExperienceList(List<Experience> experience) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: experience
          .map(
            (exp) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.jobTitle,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      exp.company,
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '${exp.startDate} - ${exp.endDate ?? 'Present'}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      exp.description,
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSkillsList(List<String> skills) {
    return Wrap(
      spacing: 8.0, // horizontal spacing
      runSpacing: 4.0, // vertical spacing
      children: skills
          .map(
            (skill) => Chip(
              label: Text(skill),
              backgroundColor: Colors.lightBlue.shade100,
              labelStyle: const TextStyle(color: Colors.blueAccent),
            ),
          )
          .toList(),
    );
  }
}