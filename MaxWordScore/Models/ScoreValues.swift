import Foundation

struct ScoreValues {
	
	let values: [Character: Int]
	
	init(values: [Int], validator: ScoreValuesValidator = DefaultScoreValuesValidator()) throws {
		
		try validator.validate(values)
		
		var tempValues: [Character: Int] = [:]
		"abcdefghijklmnopqrstuvwxyz"
			.map(Character.init)
			.enumerated()
			.forEach { index, character in
				tempValues[character] = values[index]
			}

		self.values = tempValues
	}
	
	func score(for wordGroup: WordGroup) -> Int {
		let characters = Array(wordGroup.words.joined())
		return characters.reduce(Int(0)) { total, character in
			return total + score(for: character)
		}
	}
	
	func score(for character: Character) -> Int {
		guard let score = values.first(where: { $0.key == character })?.value else {
			return 0
		}
		return score
	}
}

extension ScoreValues {
	
	static func scrabbleScore() throws -> ScoreValues {
		let values = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 0, 1, 1, 1, 1, 4, 4, 8, 4, 10]
		return try ScoreValues(values: values)
	}
	
	static func sequentialScore() throws -> ScoreValues {
		let values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0, 1, 2, 3]
		return try ScoreValues(values: values)
	}
}
