import XCTest

@testable import MaxWordScore

class DefaultLettersValidatorTests: XCTestCase {

	func testValidate_ThrowsErrorIfZeroLettersProvided() {
		
		do {
			try DefaultLettersValidator().validate([])
			XCTFail("Validate should have thrown an error")
		} catch LettersValidationError.zeroLetters {
			// Passed
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.zeroWords, got error : \(error)")
		}
	}

	func testValidate_ThrowsErrorIfMoreThanOneHundredLettersProvided() {
		
		let letters = [Character](repeating: Character("a"), count: 101)
		
		do {
			try DefaultLettersValidator().validate(letters)
			XCTFail("Validate should have thrown an error")
		} catch LettersValidationError.tooManyLetters(let count) {
			if count != 101 {
				XCTFail("Expected count to be 101, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.zeroWords, got error : \(error)")
		}
	}
}

extension DefaultLettersValidatorTests {
	
	func testValidate_DoesNotThrowWhenValid() throws {
		let letters: [Character] = ["a", "b", "c"]

		try DefaultLettersValidator().validate(letters)
		
		// Passed
	}
}
