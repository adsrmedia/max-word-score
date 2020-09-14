import XCTest

@testable import MaxWordScore

class DefaultScoreValueValidatorTests: XCTestCase {

	func testValidate_ThrowsErrorIfThereAreFewerThanTwentySixValues() {
		let values = Array(1...3)
		
		do {
			try DefaultScoreValuesValidator().validate(values)
			XCTFail("Validate should have thrown an error")
		} catch ScoreValidationError.notEnoughValues(let count) {
			if count != 3 {
				XCTFail("Expected count to be 3, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected ScoreValidationError.notEnoughValues, got error : \(error)")
		}
	}
	
	func testValidate_ThrowsErrorIfThereAreMoreThanTwentySixValues() {
		let values = Array(1...27)
		
		do {
			try DefaultScoreValuesValidator().validate(values)
			XCTFail("Validate should have thrown an error")
		} catch ScoreValidationError.tooManyValues(let count) {
			if count != 27 {
				XCTFail("Expected count to be 27, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected ScoreValidationError.tooManyValues, got error : \(error)")
		}
	}
	
	func testValidate_ThrowsErrorIfAnyValueIsLessThanZero() {
		let values = [0, 0, -4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		
		do {
			try DefaultScoreValuesValidator().validate(values)
			XCTFail("Validate should have thrown an error")
		} catch ScoreValidationError.scoreValueTooLow(let index, let value) {
			if index != 2 {
				XCTFail("Index expected to be 2, got index: \(index)")
			} else if value != -4 {
				XCTFail("Value expected to be -4, got value: \(value)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected ScoreValidationError.scoreValueTooLow, got error : \(error)")
		}
	}
	
	func testValidate_ThrowsErrorIfAnyValueIsGreaterThanTen() {
		let values = [0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		
		do {
			try DefaultScoreValuesValidator().validate(values)
			XCTFail("Validate should have thrown an error")
		} catch ScoreValidationError.scoreValueTooHigh(let index, let value) {
			if index != 3 {
				XCTFail("Index expected to be 2, got index: \(index)")
			} else if value != 15 {
				XCTFail("Value expected to be -4, got value: \(value)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected ScoreValidationError.scoreValueTooHigh, got error : \(error)")
		}
	}
}

extension DefaultScoreValueValidatorTests {
	
	func testValidate_DoesNotThrowWhenValid() throws {
		let values = [10, 0, 8, 1, 0, 2, 3, 7, 6, 6, 2, 1, 0, 0, 0, 1, 0, 0, 3, 0, 0, 1, 0, 0, 0, 10]

		try DefaultScoreValuesValidator().validate(values)
		
		// Passed
	}
}
