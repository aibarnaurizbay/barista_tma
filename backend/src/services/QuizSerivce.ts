// backend/src/services/quizService.ts

export const canTakeDailyQuiz = async (user: any): Promise<boolean> => {
  if (!user.lastQuizDate) return true; // Никогда не проходил

  const today = new Date();
  const lastQuiz = new Date(user.lastQuizDate);

  // Сравниваем год, месяц и день (учитывая часовой пояс сервера или UTC)
  const isSameDay = 
    today.getUTCFullYear() === lastQuiz.getUTCFullYear() &&
    today.getUTCMonth() === lastQuiz.getUTCMonth() &&
    today.getUTCDate() === lastQuiz.getUTCDate();

  return !isSameDay;
};

// Пример использования в контроллере (Express):
/*
export const startQuiz = async (req: Request, res: Response) => {
  const user = await userRepository.findByTelegramId(req.user.telegramId);
  
  if (!(await canTakeDailyQuiz(user))) {
    return res.status(403).json({ 
      error: 'Тест на сегодня уже пройден. Ждем на смене завтра!' 
    });
  }
  
  // Возвращаем список вопросов...
}
*/