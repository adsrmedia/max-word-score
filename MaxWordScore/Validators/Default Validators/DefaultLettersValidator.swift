import Foundation

struct DefaultLettersValidator: LettersValidator {
	
	func validate(_ letters: [Character]) throws {
		if letters.isEmpty {
			throw LettersValidationError.zeroLetters
		} else if letters.count > 100 {
			throw LettersValidationError.tooManyLetters(count: letters.count)
		}
	}
}
