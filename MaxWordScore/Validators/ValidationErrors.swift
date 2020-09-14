import Foundation

enum WordsValidationError: Error {
	case zeroWords
	case tooManyWords(count: Int)
	case wordLengthTooShort(word: String, index: Int, count: Int)
	case wordLengthTooLong(word: String, index: Int, count: Int)
}

enum ScoreValidationError: Error {
	case notEnoughValues(Int) // count
	case tooManyValues(Int) // count
	case scoreValueTooLow(Int, Int) // index, value
	case scoreValueTooHigh(Int, Int) // index, value
}

enum LettersValidationError: Error {
	case zeroLetters
	case tooManyLetters(count: Int)
}
