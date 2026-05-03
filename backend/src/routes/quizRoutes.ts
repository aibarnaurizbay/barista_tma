import { Router } from 'express';
import { Result } from '../models/Result';

const router = Router();

// Сохранение результата
router.post('/save', async (req, res) => {
  try {
    const { telegramId, username, score } = req.body;
    const newResult = new Result({ telegramId, username, score });
    await newResult.save();
    res.status(201).json({ message: 'Result saved!' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to save result' });
  }
});

export default router;