import XCTest

@testable import MaxWordScore

class LettersTests: XCTestCase {

	func testExpressibleByStringLiteral_InitFromStringCreatesEmptyCharacterArrayIfStringIsEmpty() {
		let letters = Letters("")
		
		let expectedCharacters: [Character] = []
		
		XCTAssertEqual(letters.characters, expectedCharacters)
	}
	
	func testExpressibleByStringLiteral_InitFromStringCreatesCharactersArray() {
		let letters = Letters("abcdefg")
		
		let expectedCharacters: [Character] = ["a", "b", "c", "d", "e", "f", "g"]
		
		XCTAssertEqual(letters.characters, expectedCharacters)
	}
}
