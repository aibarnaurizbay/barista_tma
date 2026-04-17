// frontend/lib/features/admin/presentation/quiz_editor.dart
import 'package:flutter/material.dart';

class QuizEditor extends StatefulWidget {
  const QuizEditor({Key? key}) : super(key: key);

  @override
  State<QuizEditor> createState() => _QuizEditorState();
}

class _QuizEditorState extends State<QuizEditor> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(4, (_) => TextEditingController());
  int _correctIndex = 0;
  final _pointsController = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать вопрос (Admin)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Текст вопроса (например, "Граммовка в эспрессо?")'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ...List.generate(4, (index) {
                return RadioListTile<int>(
                  title: TextFormField(
                    controller: _optionControllers[index],
                    decoration: InputDecoration(labelText: 'Вариант ${index + 1}'),
                  ),
                  value: index,
                  groupValue: _correctIndex,
                  onChanged: (val) => setState(() => _correctIndex = val!),
                  subtitle: const Text('Отметьте, если это правильный ответ'),
                );
              }),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pointsController,
                decoration: const InputDecoration(labelText: 'Баллы за ответ'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitQuestion,
                child: const Text('Сохранить в базу'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitQuestion() {
    if (_formKey.currentState!.validate()) {
      // Сбор данных и отправка POST-запроса на Node.js Backend
      // final newQuestion = Question(...)
    }
  }
}