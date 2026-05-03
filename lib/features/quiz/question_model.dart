class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.text, 
    required this.options, 
    required this.correctIndex
  });
}

// Временный список вопросов для теста
final List<Question> coffeeQuiz = [
  Question(
    text: "Какой помол нужен для классического эспрессо?",
    options: ["Крупный", "Средний", "Мелкий", "В пыль"],
    correctIndex: 2,
  ),
  Question(
    text: "Что такое 'Доппио'?",
    options: ["Кофе с молоком", "Двойной эспрессо", "Холодный кофе", "Вид арабики"],
    correctIndex: 1,
  ),
];