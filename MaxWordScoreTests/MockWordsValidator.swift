import Foundation

@testable import MaxWordScore

final class MockWordsValidator: WordsValidator {

	var error: Error?
	var validateCallTally = 0
	
	func validate(_ words: [String]) throws {
		validateCallTally += 1
		if let error = error {
			throw error
		}
	}
}
