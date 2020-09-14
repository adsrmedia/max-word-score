import Foundation

struct DefaultScoreValuesValidator: ScoreValuesValidator {
	
	func validate(_ values: [Int]) throws {
		switch values.count {
		case 26:
			break
		case 0...25:
			throw ScoreValidationError.notEnoughValues(values.count)
		default:
			throw ScoreValidationError.tooManyValues(values.count)
		}
		
		try values.enumerated().forEach { index, value in
			guard value >= 0 else {
				throw ScoreValidationError.scoreValueTooLow(index, value)
			}
			guard value <= 10 else {
				throw ScoreValidationError.scoreValueTooHigh(index, value)
			}
		}
	}
}
