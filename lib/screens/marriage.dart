import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:provider/provider.dart';
import '../controllers/marriage_controller.dart';

class MarriageScreen extends StatelessWidget {
  const MarriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marriage Details'),
      ),
      body: Consumer<MarriageController>(
        builder: (context, controller, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: controller.partner1NameController,
                  decoration: const InputDecoration(
                    labelText: 'Partner 1 Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: controller.setPartner1Name,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.partner2NameController,
                  decoration: const InputDecoration(
                    labelText: 'Partner 2 Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: controller.setPartner2Name,
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () => controller.pickDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: controller.selectedDate != null
                            ? DateFormat.yMMMd().format(controller.selectedDate!)
                            : '',
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Marriage Date',
                        hintText: 'Select Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.venueController,
                  decoration: const InputDecoration(
                    labelText: 'Venue',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: controller.setVenue,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    controller.submitMarriageDetails();
                    // Optionally, show a success message or navigate
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Details submitted (check console)!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: const Text(
                    'Save Details',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Display current state for debugging/verification
                Text(
                  'Current Stored Details:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Partner 1: ${controller.marriageDetails.partner1Name ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Partner 2: ${controller.marriageDetails.partner2Name ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Date: ${controller.marriageDetails.marriageDate != null ? DateFormat.yMMMd().format(controller.marriageDetails.marriageDate!) : 'N/A'}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Venue: ${controller.marriageDetails.venue ?? 'N/A'}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}