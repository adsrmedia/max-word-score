import Foundation

@testable import MaxWordScore

final class MockLettersValidator: LettersValidator {

	var error: Error?
	var validateCallTally = 0
	
	func validate(_ letters: [Character]) throws {
		validateCallTally += 1
		if let error = error {
			throw error
		}
	}
}
