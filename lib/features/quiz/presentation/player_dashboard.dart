// frontend/lib/features/quiz/presentation/player_dashboard.dart
import 'package:flutter/material.dart';

class PlayerDashboard extends StatelessWidget {
  final int balance;
  final bool isQuizAvailable;

  const PlayerDashboard({
    Key? key,
    required this.balance,
    required this.isQuizAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barista Hub')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dashboard Balance Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Твой баланс', style: TextStyle(fontSize: 18)),
                    Text(
                      '$balance баллов',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Quiz Status Action
            ElevatedButton(
              onPressed: isQuizAvailable 
                  ? () => _startQuiz(context) 
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: isQuizAvailable ? Colors.green : Colors.grey,
              ),
              child: Text(
                isQuizAvailable ? 'Пройти Тест Дня' : 'Тест на сегодня пройден',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context) {
    // Навигация на экран движка викторины
    // Navigator.pushNamed(context, '/quiz_engine');
  }
}