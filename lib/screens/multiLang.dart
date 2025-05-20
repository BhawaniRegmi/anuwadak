import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'multilingual_interface_controller.dart';
import 'multilingual_interface_model.dart';

class MultilingualInterfaceScreen extends StatelessWidget {
  const MultilingualInterfaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MultilingualInterfaceController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select App Language'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<MultilingualInterfaceController>(
            builder: (context, controller, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your preferred language:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<LanguageOption>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'App Language',
                    ),
                    value: controller.currentLanguage,
                    items: controller.supportedLanguages.map((LanguageOption language) {
                      return DropdownMenuItem<LanguageOption>(
                        value: language,
                        child: Text(language.displayName),
                      );
                    }).toList(),
                    onChanged: (LanguageOption? selectedLanguage) {
                      controller.setCurrentLanguage(selectedLanguage);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Current Language:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.currentLanguage?.displayName ?? 'Not selected',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Note:',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                  const Text(
                    'In a real application, changing the language here would trigger a full UI rebuild using localization packages to display all text in the selected language.',
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}