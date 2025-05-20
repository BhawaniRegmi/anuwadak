import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_advertisement_example/controllers/image_translation_controller.dart'; // Adjust import path

class ImageTranslationScreen extends StatelessWidget {
  const ImageTranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageTranslationController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image Translation'),
        ),
        body: Consumer<ImageTranslationController>(
          builder: (context, controller, child) {
            final state = controller.state;

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (state.imagePath != null)
                    Column(
                      children: [
                        Image.file(File(state.imagePath!), height: 200),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: controller.selectImage,
                    child: const Text('Select Image from Gallery'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: controller.captureImage,
                    child: const Text('Capture Image with Camera'),
                  ),
                  const SizedBox(height: 24),
                  if (state.originalText != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Original Text:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(state.originalText!),
                        const SizedBox(height: 16),
                      ],
                    ),
                  if (state.translatedText != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Translated Text:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(state.translatedText!),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}