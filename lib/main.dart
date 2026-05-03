import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/telegram_web_app.dart'; 
import 'features/quiz/quiz_screen.dart'; // Тот самый импорт для викторины

void main() {
  runApp(const ProviderScope(child: BaristaTmaApp()));
}

class BaristaTmaApp extends StatelessWidget {
  const BaristaTmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barista Quiz',
      theme: ThemeData(colorSchemeSeed: Colors.brown, useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    TelegramWebApp.ready();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.coffee, size: 80, color: Colors.brown),
            SizedBox(height: 24),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Инициализация Telegram...'),
          ],
        ),
      ),
    );
  }
}

// ВОТ ЭТОГО КУСКА У ТЕБЯ НЕ ХВАТАЛО:
class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = TelegramWebApp.userData;
    final String name = user?['first_name'] ?? "Бариста";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barista Quiz'),
        backgroundColor: Colors.brown.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Добро welcome, $name!', 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Переход на экран викторины
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Начать тест дня'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}