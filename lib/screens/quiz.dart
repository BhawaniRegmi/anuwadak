import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/questions_data.dart'; // Import your question data

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  bool _answerWasSelected = false;
  bool _isCorrectAnswer = false;
  String? _selectedOptionText;

  // For simplicity, we'll use the readingQuestions for this example
  final List<Question> _questions = readingQuestions;

  void _answerQuestion(int selectedOptionIndex) {
    setState(() {
      _answerWasSelected = true;
      _isCorrectAnswer = selectedOptionIndex == _questions[_questionIndex].correctAnswerIndex;
      _selectedOptionText = _questions[_questionIndex].options[selectedOptionIndex];

      if (_isCorrectAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      _answerWasSelected = false;
      _isCorrectAnswer = false;
      _selectedOptionText = null;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _answerWasSelected = false;
      _isCorrectAnswer = false;
      _selectedOptionText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You completed the quiz!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'Your score: $_score out of ${_questions.length}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _resetQuiz,
                child: const Text('Restart Quiz'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to Home Screen
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Practice'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_questionIndex + 1}/${_questions.length}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              currentQuestion.questionText,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ...currentQuestion.options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;

              Color buttonColor = Colors.blueGrey; // Default
              if (_answerWasSelected) {
                if (index == currentQuestion.correctAnswerIndex) {
                  buttonColor = Colors.green; // Correct answer
                } else if (option == _selectedOptionText) {
                  buttonColor = Colors.red; // User's incorrect answer
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _answerWasSelected
                        ? null // Disable button after selection
                        : () => _answerQuestion(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor, // Use custom color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(option),
                  ),
                ),
              );
            }).toList(),
            if (_answerWasSelected && currentQuestion.explanation != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Card(
                  color: Colors.blue.shade50,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isCorrectAnswer ? 'Correct!' : 'Incorrect.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isCorrectAnswer ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explanation: ${currentQuestion.explanation}',
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const Spacer(), // Pushes content to the top
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _answerWasSelected ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(_questionIndex < _questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}