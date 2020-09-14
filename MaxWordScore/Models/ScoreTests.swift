import XCTest

@testable import MaxWordScore

class ScoreValuesTests: XCTestCase {
	
	func testInit_ThrowsErrorFromValidator() {
		let mockValidator = MockScoreValuesValidator()
		mockValidator.error = ScoreValidationError.notEnoughValues(5)
		
		do {
			_ = try ScoreValues(values: Array(1...5), validator: mockValidator)
			XCTFail("Init should have thrown an error")
		} catch ScoreValidationError.notEnoughValues(let count) {
			if count != 5 {
				XCTFail("Expected count to be 5, got count: \(count)")
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected ScoreValidationError.notEnoughValues, got error : \(error)")
		}
	}
}

extension ScoreValuesTests {
	
	func testScoreForCharacter_ReturnsZeroIfNotFound() throws {
		let score = try ScoreValues.scrabbleScore()

		let actualScore = score.score(for: "F")
		
		XCTAssertEqual(actualScore, 0)
	}
	
	func testScoreForCharacter_ReturnsScoreIfFound() throws {
		let score = try ScoreValues.scrabbleScore()

		let actualScore = score.score(for: "f")
		
		XCTAssertEqual(actualScore, 4)
	}
}

extension ScoreValuesTests {
	
	func testScoreForWordGroup_ReturnsCorrectScore() throws {
		let wordGroup = WordGroup(words: ["some", "group", "of", "words"])
		
		let score = try ScoreValues.scrabbleScore()
		
		let actualScore = score.score(for: wordGroup)
		
		XCTAssertEqual(actualScore, 28)
	}
}

extension ScoreValuesTests {
	
	func testScrabbleScore_ReturnsCorrectValues() throws {
		let expectedValues: [Character: Int] = [
			"a": 1,
			"b": 3,
			"c": 3,
			"d": 2,
			"e": 1,
			"f": 4,
			"g": 2,
			"h": 4,
			"i": 1,
			"j": 8,
			"k": 5,
			"l": 1,
			"m": 3,
			"n": 1,
			"o": 1,
			"p": 3,
			"q": 0,
			"r": 1,
			"s": 1,
			"t": 1,
			"u": 1,
			"v": 4,
			"w": 4,
			"x": 8,
			"y": 4,
			"z": 10
		]

		let scrabbleScore = try ScoreValues.scrabbleScore()
		
		XCTAssertEqual(scrabbleScore.values, expectedValues)
	}
	
	func testSequentialScore_ReturnsCorrectValues() throws {
		let expectedValues: [Character: Int] = [
			"a": 0,
			"b": 1,
			"c": 2,
			"d": 3,
			"e": 4,
			"f": 5,
			"g": 6,
			"h": 7,
			"i": 8,
			"j": 9,
			"k": 10,
			"l": 0,
			"m": 1,
			"n": 2,
			"o": 3,
			"p": 4,
			"q": 5,
			"r": 6,
			"s": 7,
			"t": 8,
			"u": 9,
			"v": 10,
			"w": 0,
			"x": 1,
			"y": 2,
			"z": 3
		]

		let sequentialScore = try ScoreValues.sequentialScore()
		
		XCTAssertEqual(sequentialScore.values, expectedValues)
	}
}
