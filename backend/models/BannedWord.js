const mongoose = require('mongoose');

const bannedWordSchema = new mongoose.Schema({
  word: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    trim: true
  },
  category: {
    type: String,
    enum: ['profanity', 'offensive', 'spam', 'other'],
    default: 'other'
  },
  severity: {
    type: String,
    enum: ['low', 'medium', 'high'],
    default: 'medium'
  },
  isActive: {
    type: Boolean,
    default: true
  },
  addedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Admin'
  }
}, {
  timestamps: true
});

// Metin içinde yasaklı kelime kontrolü (static method)
bannedWordSchema.statics.checkText = async function(text) {
  if (!text) return { isClean: true, foundWords: [] };
  
  const bannedWords = await this.find({ isActive: true });
  const foundWords = [];
  const lowerText = text.toLowerCase();
  
  for (const bannedWord of bannedWords) {
    const regex = new RegExp(`\\b${bannedWord.word}\\b`, 'gi');
    if (regex.test(lowerText)) {
      foundWords.push({
        word: bannedWord.word,
        category: bannedWord.category,
        severity: bannedWord.severity
      });
    }
  }
  
  return {
    isClean: foundWords.length === 0,
    foundWords
  };
};

// Metni temizle (yasaklı kelimeleri * ile değiştir)
bannedWordSchema.statics.cleanText = async function(text) {
  if (!text) return text;
  
  const bannedWords = await this.find({ isActive: true });
  let cleanedText = text;
  
  for (const bannedWord of bannedWords) {
    const regex = new RegExp(`\\b${bannedWord.word}\\b`, 'gi');
    cleanedText = cleanedText.replace(regex, '*'.repeat(bannedWord.word.length));
  }
  
  return cleanedText;
};

// Toplu ekleme (static method)
bannedWordSchema.statics.addMultiple = async function(words, adminId) {
  const results = {
    added: [],
    skipped: [],
    errors: []
  };
  
  for (const word of words) {
    try {
      const existing = await this.findOne({ word: word.toLowerCase() });
      if (existing) {
        results.skipped.push(word);
      } else {
        await this.create({
          word: word.toLowerCase(),
          addedBy: adminId
        });
        results.added.push(word);
      }
    } catch (error) {
      results.errors.push({ word, error: error.message });
    }
  }
  
  return results;
};

// Indexes
bannedWordSchema.index({ word: 1 });
bannedWordSchema.index({ isActive: 1 });
bannedWordSchema.index({ category: 1 });

module.exports = mongoose.model('BannedWord', bannedWordSchema);
