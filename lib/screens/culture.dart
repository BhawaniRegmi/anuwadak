import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cultural_context_controller.dart';
import 'cultural_context_model.dart';

class CulturalContextTranslationScreen extends StatelessWidget {
  const CulturalContextTranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CulturalContextController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cultural Context Translation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CulturalContextController>(
            builder: (context, controller, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter text to translate',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Translate to',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedTargetLanguage,
                    items: controller.supportedLanguages.map((language) {
                      return DropdownMenuItem(
                        value: language,
                        child: Text(language),
                      );
                    }).toList(),
                    onChanged: controller.setSelectedTargetLanguage,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: controller.isLoading ? null : controller.translateWithCulturalContext,
                    child: controller.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Translate with Context'),
                  ),
                  const SizedBox(height: 20),
                  if (controller.translationResult != null)
                    _buildTranslationResult(controller.translationResult!),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTranslationResult(CulturalContextResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Translation:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(result.translatedText, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        if (result.culturalNote != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cultural Note:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              Text(result.culturalNote!, style: const TextStyle(color: Colors.orange)),
              const SizedBox(height: 10),
            ],
          ),
        if (result.alternativePhrases != null && result.alternativePhrases!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alternative Phrases:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              ...result.alternativePhrases!.map((phrase) => Text('- $phrase', style: const TextStyle(color: Colors.blue))).toList(),
            ],
          ),
      ],
    );
  }
}