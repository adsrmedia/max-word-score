import XCTest

@testable import MaxWordScore

class DefaultWordsValidatorTests: XCTestCase {
	
	func testValidate_ThrowsErrorIfZeroWordsAreProvided() {
		
		do {
			try DefaultWordsValidator().validate([])
			XCTFail("Validate should have thrown an error")
		} catch WordsValidationError.zeroWords {
			// Passed
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.zeroWords, got error : \(error)")
		}
	}
	
	func testValidate_ThrowsErrorIfTooManyWordsAreProvided() {
		let words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen"]
		
		do {
			try DefaultWordsValidator().validate(words)
			XCTFail("Validate should have thrown an error")
		} catch WordsValidationError.tooManyWords(let count) {
			if count != 15 {
				XCTFail("Expected count to be 15, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.zeroWords, got error : \(error)")
		}
	}
	
	func testValidate_ThrowsErrorIfAnyWordIsTooShort() {
		let words = ["one", "", "three"]
		
		do {
			try DefaultWordsValidator().validate(words)
			XCTFail("Validate should have thrown an error")
		} catch WordsValidationError.wordLengthTooShort(let word, let index, let count) {
			if word != "" {
				XCTFail("Expected word to be \"\", got word: \(word)")
			} else if index != 1 {
				XCTFail("Expected index to be 1, got index: \(index)")
			} else if count != 0 {
				XCTFail("Expected count to be 0, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.wordLengthTooShort, got error : \(error)")
		}
	}
	
	func testValidate_ThrowsErrorIfAnyWordIsTooLong() {
		let words = ["one", "two", "threeFourFiveSix"]
		
		do {
			try DefaultWordsValidator().validate(words)
			XCTFail("Validate should have thrown an error")
		} catch WordsValidationError.wordLengthTooLong(let word, let index, let count) {
			if word != "threeFourFiveSix" {
				XCTFail("Expected word to be \"threeFourFiveSix\", got word: \(word)")
			} else if index != 2 {
				XCTFail("Expected index to be 2, got index: \(index)")
			} else if count != 16 {
				XCTFail("Expected count to be 0, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.wordLengthTooLong, got error : \(error)")
		}
	}
}

extension DefaultWordsValidatorTests {
	
	func testValidate_DoesNotThrowWhenValid() throws {
		let words = ["one", "two", "three"]

		try DefaultWordsValidator().validate(words)
		
		// Passed
	}
}
