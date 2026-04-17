import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/telegram_web_app.dart'; // Импортируем наш мост

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
  String? userName;

  @override
  void initState() {
    super.initState();
    // Инициализируем Telegram
    TelegramWebApp.ready();
    
    // Пытаемся получить данные пользователя
    final user = TelegramWebApp.userData;
    if (user != null) {
      setState(() {
        userName = user['first_name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.coffee, size: 80, color: Colors.brown),
            const SizedBox(height: 24),
            Text(
              userName != null ? 'Привет, $userName!' : 'Загрузка...',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}