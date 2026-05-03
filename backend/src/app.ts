import express from 'express';
import cors from 'cors';
import mongoose from 'mongoose';

const app = express();
const PORT = process.env.PORT || 3000;

// Разрешаем запросы с твоего фронтенда на GitHub Pages
app.use(cors());
app.use(express.json());

// Подключение к MongoDB (замени ссылку на свою из Atlas позже)
const MONGO_URI = 'mongodb://localhost:27017/barista_quiz'; 
mongoose.connect(MONGO_URI)
  .then(() => console.log('✅ MongoDB connected'))
  .catch(err => console.error('❌ MongoDB error:', err));

// Простой проверочный маршрут
app.get('/', (req, res) => {
  res.send('Barista Quiz Server is running! ☕');
});

app.listen(PORT, () => {
  console.log(`🚀 Server started on http://localhost:${PORT}`);
});

export default app;