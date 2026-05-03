import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'question_model.dart'; 
import '../../core/telegram_web_app.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  Future<void> sendResultToServer(int finalScore) async {
    final user = TelegramWebApp.userData;
    // ВАЖНО: localhost не будет работать с телефона, 
    // но для теста в браузере пойдет.
    final url = Uri.parse('http://localhost:3000/api/quiz/save'); 

    try {
      await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "telegramId": user?['id']?.toString() ?? "00000",
          "username": user?['first_name'] ?? "Unknown",
          "score": finalScore,
        }),
      );
      print("Результат отправлен!");
    } catch (e) {
      print("Ошибка при отправке: $e");
    }
  }

  void checkAnswer(int index) {
    if (index == coffeeQuiz[currentQuestionIndex].correctIndex) {
      score++;
    }

    setState(() {
      if (currentQuestionIndex < coffeeQuiz.length - 1) {
        currentQuestionIndex++;
      } else {
  sendResultToServer(score); // Добавь эту строку
  _showResultDialog();
}
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Тест завершен!"),
        content: Text("Твой результат: $score из ${coffeeQuiz.length}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Круто!"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = coffeeQuiz[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Вопрос ${currentQuestionIndex + 1}")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: (currentQuestionIndex + 1) / coffeeQuiz.length),
            const SizedBox(height: 40),
            Text(question.text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ...List.generate(question.options.length, (index) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    child: Text(question.options[index]),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}