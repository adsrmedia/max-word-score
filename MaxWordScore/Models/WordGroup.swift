import Foundation

struct WordGroup: Hashable {
	let words: [String]
	
	init(words: [String]) {
		self.words = words
	}
	
	func isValid(for letters: Letters) -> Bool {
		var remainingLetters = letters.characters
		
		return words.allSatisfy { word in
			let isValidWord = word.allSatisfy { character in
				guard let characterIndex = remainingLetters.firstIndex(of: character) else {
					return false
				}
				remainingLetters.remove(at: characterIndex)
				return true
			}
			return isValidWord
		}
	}
}
