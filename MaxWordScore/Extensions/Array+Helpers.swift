import Foundation

extension Array where Element: Comparable {
	
	/// Returns all possible combinations of the elements in the array
	/// with no repetitions.
	var combinationsWithoutRepetition: [[Element]] {
		guard !isEmpty else {
			return [[]]
		}
		
		return Array(self[1...])
			.combinationsWithoutRepetition
			.flatMap {
				[$0, [self[0]] + $0]
			}
	}
}
