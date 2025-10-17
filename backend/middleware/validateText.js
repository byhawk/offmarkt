const { asyncHandler } = require('./errorHandler');
const BannedWord = require('../models/BannedWord');

// Metin validasyonu middleware
const validateText = (fields) => {
  return asyncHandler(async (req, res, next) => {
    const textsToCheck = [];
    
    // Belirtilen alanları kontrol et
    for (const field of fields) {
      if (req.body[field]) {
        textsToCheck.push({
          field,
          text: req.body[field]
        });
      }
    }
    
    // Yasaklı kelime kontrolü
    for (const item of textsToCheck) {
      const result = await BannedWord.checkText(item.text);
      
      if (!result.isClean) {
        return res.status(400).json({
          success: false,
          message: `${item.field} alanında yasaklı kelime tespit edildi`,
          bannedWords: result.foundWords.map(w => w.word)
        });
      }
    }
    
    next();
  });
};

// Otomatik temizleme middleware
const cleanText = (fields) => {
  return asyncHandler(async (req, res, next) => {
    for (const field of fields) {
      if (req.body[field]) {
        req.body[field] = await BannedWord.cleanText(req.body[field]);
      }
    }
    next();
  });
};

module.exports = {
  validateText,
  cleanText
};
