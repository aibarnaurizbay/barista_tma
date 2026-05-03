import { Schema, model } from 'mongoose';

const resultSchema = new Schema({
  telegramId: { type: String, required: true },
  username: { type: String, default: 'Anonymous' },
  score: { type: Number, required: true },
  date: { type: Date, default: Date.now }
});

export const Result = model('Result', resultSchema);