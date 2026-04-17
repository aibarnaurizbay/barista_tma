// backend/src/models/types.ts

export interface User {
  telegramId: number; // Берем из initData
  username?: string;
  firstName: string;
  role: 'barista' | 'admin';
  balance: number; // Текущие баллы
  lastQuizDate?: Date | null; // Дата последнего прохождения ежедневного теста
}

export interface Question {
  id: string;
  text: string;
  options: string[]; // Массив из 4 вариантов
  correctOptionIndex: number; // Индекс правильного ответа (0-3)
  points: number; // Сколько баллов дает правильный ответ
  isActive: boolean; // Можно ли использовать вопрос в текущих тестах
}

export interface Product {
  id: string;
  title: string;
  description: string;
  price: number; // Цена в баллах
  imageUrl: string;
  inStock: boolean;
}

export interface Order {
  id: string;
  userId: number;
  productId: string;
  status: 'pending' | 'completed' | 'cancelled';
  createdAt: Date;
}