import XCTest

@testable import MaxWordScore

class ScoreCalculatorTests: XCTestCase {
	
	func testMaxScore_ThrowsErrorIfWordsValidatorThrowsError() throws {
		let mockWordsValidator = MockWordsValidator()
		let mockLettersValidator = MockLettersValidator()
		let mockScoreValuesValidator = MockScoreValuesValidator()
		
		mockWordsValidator.error = WordsValidationError.tooManyWords(count: 35)

		let scoreCalculator = ScoreCalculator(
			wordsValidator: mockWordsValidator,
			lettersValidator: mockLettersValidator,
			scoreValuesValidator: mockScoreValuesValidator
		)
		
		do {
			_ = try scoreCalculator.maxScore(words: [], letters: "", scoreValues: [])
			XCTFail("ScoreCalculator should have thrown an error")
		} catch WordsValidationError.tooManyWords(let count) {
			if count != 35 {
				XCTFail("Expected count to be 35, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected WordsValidationError.tooManyWords(count: 35), got error : \(error)")
		}
	}
	
	func testMaxScore_ThrowsErrorIfLettersValidatorThrowsError() throws {
		let mockWordsValidator = MockWordsValidator()
		let mockLettersValidator = MockLettersValidator()
		let mockScoreValuesValidator = MockScoreValuesValidator()
		
		mockLettersValidator.error = LettersValidationError.tooManyLetters(count: 30)

		let scoreCalculator = ScoreCalculator(
			wordsValidator: mockWordsValidator,
			lettersValidator: mockLettersValidator,
			scoreValuesValidator: mockScoreValuesValidator
		)
		
		do {
			_ = try scoreCalculator.maxScore(words: [], letters: "", scoreValues: [])
			XCTFail("ScoreCalculator should have thrown an error")
		} catch LettersValidationError.tooManyLetters(let count) {
			if count != 30 {
				XCTFail("Expected count to be 30, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected LettersValidationError.tooManyLetters(count: 30), got error : \(error)")
		}
	}
	
	func testMaxScore_ThrowsErrorIfScoreValidatorThrowsError() throws {
		let mockWordsValidator = MockWordsValidator()
		let mockLettersValidator = MockLettersValidator()
		let mockScoreValuesValidator = MockScoreValuesValidator()
		
		mockScoreValuesValidator.error = ScoreValidationError.notEnoughValues(5)

		let scoreCalculator = ScoreCalculator(
			wordsValidator: mockWordsValidator,
			lettersValidator: mockLettersValidator,
			scoreValuesValidator: mockScoreValuesValidator
		)
		
		do {
			_ = try scoreCalculator.maxScore(words: [], letters: "", scoreValues: [])
			XCTFail("ScoreCalculator should have thrown an error")
		} catch ScoreValidationError.notEnoughValues(let count) {
			if count != 5 {
				XCTFail("Expected count to be 5, got count: \(count)")
			} else {
				// Passed
			}
		} catch {
			XCTFail("Incorrect error thrown.  Expected ScoreValidationError.notEnoughValues(count: 5), got error : \(error)")
		}
	}
}

/// Examples from the source of the exercise
/// See: Rules.md
extension ScoreCalculatorTests {
	
	func testExample1() throws {
		let words = ["dog", "cat", "dad", "good"]
		let letters = Letters("aacdddgoo")
		let score = [1,0,9,5,0,0,3,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0]

		let actualScore = try ScoreCalculator().maxScore(words: words, letters: letters, scoreValues: score)

		XCTAssertEqual(actualScore, 23)
	}
	
	func testExample2() throws {
		
		let words = ["xxxz", "ax", "bx", "cx"]
		let letters = Letters("zabcxxx")
		let score = [4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,10]

		let actualScore = try ScoreCalculator().maxScore(words: words, letters: letters, scoreValues: score)

		XCTAssertEqual(actualScore, 27)
	}
	
	func testExample3() throws {
		
		let words = ["leetcode"]
		let letters = Letters("letcod")
		let score = [0,0,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0]

		let actualScore = try ScoreCalculator().maxScore(words: words, letters: letters, scoreValues: score)

		XCTAssertEqual(actualScore, 0)
	}
}

extension ScoreCalculatorTests {
	
	func testAvailableWordGroups_ReturnsEmptyArrayIfNoWordsProvided() {
		
		let actualWordGroups = ScoreCalculator().availableWordGroups(from: [])

		XCTAssertEqual(actualWordGroups, [])
	}
	
	func testAvailableWordGroups_ReturnsAllCombinationsOfWordGroups() {

		let words = ["one", "two", "three", "four"]
		
		let actualWordGroups = ScoreCalculator().availableWordGroups(from: words)
		
		let expectedWordGroups = [
			WordGroup(words: ["one"]),
			WordGroup(words: ["two"]),
			WordGroup(words: ["one", "two"]),
			WordGroup(words: ["three"]),
			WordGroup(words: ["one", "three"]),
			WordGroup(words: ["two", "three"]),
			WordGroup(words: ["one", "two", "three"]),
			WordGroup(words: ["four"]),
			WordGroup(words: ["one", "four"]),
			WordGroup(words: ["two", "four"]),
			WordGroup(words: ["one", "two", "four"]),
			WordGroup(words: ["three", "four"]),
			WordGroup(words: ["one", "three", "four"]),
			WordGroup(words: ["two", "three", "four"]),
			WordGroup(words: ["one", "two", "three", "four"])
		]
		
		XCTAssertEqual(actualWordGroups, expectedWordGroups)
	}
}

extension ScoreCalculatorTests {
	
	func testValidWordGroups_ReturnsEmptyArrayIfNoWordGroupsAreValid() {
		let words = ["one", "two", "three", "four"]
		let letters = Letters("zxrp")
		
		let actualWordGroups = ScoreCalculator().validWordGroups(from: words, letters: letters)
		
		XCTAssertEqual(actualWordGroups, [])
	}
	
	func testValidWordGroups_ReturnsWordGroupsThatAreValid() {
		let words = ["one", "two", "three", "four"]
		let letters = Letters("thonetwore")
		
		let actualWordGroups = ScoreCalculator().validWordGroups(from: words, letters: letters)
		
		let expectedWordGroups = [
			WordGroup(words: ["one"]),
			WordGroup(words: ["two"]),
			WordGroup(words: ["one", "two"]),
			WordGroup(words: ["three"]),
			WordGroup(words: ["two", "three"])
		]
		
		XCTAssertEqual(actualWordGroups, expectedWordGroups)
	}
}
