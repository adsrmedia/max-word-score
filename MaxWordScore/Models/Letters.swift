import Foundation

struct Letters {
	let characters: [Character]
}

extension Letters: ExpressibleByStringLiteral {
	typealias StringLiteralType = String
	
	init(stringLiteral: String) {
		characters = Array(stringLiteral)
	}
}
