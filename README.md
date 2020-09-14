#  1255. Maximum Score Words Formed by Letters

This exercise was taken from Leetcode: https://leetcode.com/problems/maximum-score-words-formed-by-letters/

While the intention for this exercise was to make a solution in a single function, I decided to make it into a user-interactive app that has tests.

I am still working on building out the UI (with SwiftUI) but I have a solution for finding the max possible score.  The function cited in the exercise as a starting place can be found in the [ScoreCalculator.swift](MaxWordScore/Models/ScoreCalculator.swift) file.  All the business rules have tests.  I am always thinking of new ways to refactor to make cleaner, more readable, and more maintainable code.

The rules to this exercise can be found at the Leetcode link above or in this [Rules.md](MaxWordScore/Rules.md) file in this project.

The solution separates the three elements into their own models that have their own validators to safeguard the inputs.  The validators each conform to a protocol to allow for the creation of mock validators to be used in other tests.  The models have their own functions that assist with the calculation of the best score.  Those all have tests as well.

The ScoreCalculator combines all these elements to find the maximum possible valid score for the set of words using the letters and provided score sheet.

Future Development
- Return words that create the maximum score
- Create robust UI using SwiftUI
- Incorporate Combine
