import XCTest

@testable import MaxWordScore

class WordGroupTests: XCTestCase {
	
	func testIsValid_ReturnsFalseIfWordsUseTooManyCharacters() throws {
		
		let wordGroup = WordGroup(words: ["a", "b", "c", "d"])
		
		let isValid = wordGroup.isValid(for: Letters("abc"))
		
		XCTAssertFalse(isValid)
	}
	
	func testIsValid_ReturnsTrueIfLettersProvidesEnoughCharactersForEachWord() throws {
		
		let wordGroup = WordGroup(words: ["happy", "times", "are", "here", "again"])
		
		let isValid = wordGroup.isValid(for: Letters("happytimesarehereagainwithextraletters"))
		
		XCTAssertTrue(isValid)
	}
	
	func testIsValid_ReturnsTrueIfLettersProvidesEnoughCharactersForEachWord_WhereCharacterOrderDoesNotMatter() throws {
		
		let wordGroup = WordGroup(words: ["a", "b", "c", "d", "e"])
		
		let isValid = wordGroup.isValid(for: Letters("cbeda"))
		
		XCTAssertTrue(isValid)
	}
}
