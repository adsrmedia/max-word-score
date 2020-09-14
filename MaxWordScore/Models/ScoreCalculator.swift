import Foundation

struct ScoreCalculator {
	
	private let wordsValidator: WordsValidator
	private let lettersValidator: LettersValidator
	private let scoreValuesValidator: ScoreValuesValidator

	init(
		wordsValidator: WordsValidator = DefaultWordsValidator(),
		lettersValidator: LettersValidator = DefaultLettersValidator(),
		scoreValuesValidator: ScoreValuesValidator = DefaultScoreValuesValidator()
	) {
		self.wordsValidator = wordsValidator
		self.lettersValidator = lettersValidator
		self.scoreValuesValidator = scoreValuesValidator
	}
	
	func maxScore(words: [String], letters: Letters, scoreValues: [Int]) throws -> Int {
		
		try wordsValidator.validate(words)
		try lettersValidator.validate(letters.characters)
		
		let wordGroups = validWordGroups(from: words, letters: letters)
		let scoreValues = try ScoreValues(values: scoreValues, validator: scoreValuesValidator)
		
		return wordGroups.reduce(0) { (maxScore, wordGroup) -> Int in
			let wordGroupScore = scoreValues.score(for: wordGroup)
			return max(maxScore, wordGroupScore)
		}
	}
	
	func availableWordGroups(from words: [String]) -> [WordGroup] {
		return words
			.combinationsWithoutRepetition
			.filter { !$0.isEmpty }
			.map(WordGroup.init)
	}
	
	func validWordGroups(from words: [String], letters: Letters) -> [WordGroup] {
		let wordGroups = availableWordGroups(from: words).filter { wordGroup in
			wordGroup.isValid(for: letters)
		}
		return wordGroups
	}
}
