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
	
	func maxScoreWords(words: [String], letters: [Character], scoreValues: [Int]) throws -> Int {
		
		try wordsValidator.validate(words)
		try lettersValidator.validate(letters)
		try scoreValuesValidator.validate(scoreValues)
		
		return 0
	}
}
