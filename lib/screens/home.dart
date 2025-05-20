import 'package:flutter/material.dart';
import 'package:anuwadak/controllers/translation_controller.dart';
import 'package:anuwadak/models/language_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TranslationController _translationController = TranslationController();
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = '';
  Language? _sourceLanguage;
  Language? _targetLanguage;

  @override
  void initState() {
    super.initState();
    _translationController.fetchSupportedLanguages(); // Assuming this fetches languages
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _translateText() async {
    if (_inputController.text.isNotEmpty &&
        _sourceLanguage != null &&
        _targetLanguage != null) {
      setState(() {
        _translatedText = 'Translating...';
      });
      final String? translation = await _translationController.translate(
        _inputController.text,
        _sourceLanguage!.code,
        _targetLanguage!.code,
      );
      setState(() {
        _translatedText = translation ?? 'Translation failed.';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter text and select languages.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anuwadak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton<Language>(
                  value: _sourceLanguage,
                  hint: const Text('Source Language'),
                  items: _translationController.supportedLanguages.map((Language language) {
                    return DropdownMenuItem<Language>(
                      value: language,
                      child: Text(language.name),
                    );
                  }).toList(),
                  onChanged: (Language? newValue) {
                    setState(() {
                      _sourceLanguage = newValue;
                    });
                  },
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<Language>(
                  value: _targetLanguage,
                  hint: const Text('Target Language'),
                  items: _translationController.supportedLanguages.map((Language language) {
                    return DropdownMenuItem<Language>(
                      value: language,
                      child: Text(language.name),
                    );
                  }).toList(),
                  onChanged: (Language? newValue) {
                    setState(() {
                      _targetLanguage = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _translateText,
              child: const Text('Translate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Translated Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_translatedText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}