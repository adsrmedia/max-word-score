import Foundation

struct DefaultWordsValidator: WordsValidator {
	
	func validate(_ words: [String]) throws {
		switch words.count {
		case 0:
			throw WordsValidationError.zeroWords
		case 1...14:
			break
		default:
			throw WordsValidationError.tooManyWords(count: words.count)
		}
		
		try words.enumerated().forEach { index, word in
			if word.count > 15 {
				throw WordsValidationError.wordLengthTooLong(word: word, index: index, count: word.count)
			} else if word.isEmpty {
				throw WordsValidationError.wordLengthTooShort(word: word, index: index, count: word.count)
			}
		}
	}
}
