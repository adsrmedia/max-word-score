import Foundation

@testable import MaxWordScore

final class MockScoreValuesValidator: ScoreValuesValidator {

	var error: Error?
	var validateCallTally = 0
	
	func validate(_ values: [Int]) throws {
		validateCallTally += 1
		if let error = error {
			throw error
		}
	}
}
