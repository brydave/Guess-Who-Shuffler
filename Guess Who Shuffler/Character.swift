import Foundation

struct Character: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var imageName: String { name.lowercased() }

    static let all: [Character] = [
        "Al", "Amy", "Emma", "Jordan", "Sam", "Sofia",
        "Gabe", "Joe", "Rachel", "Mike", "Katie", "Lily",
        "Nick", "Liz", "Olivia", "Eric", "Leo", "Laura",
        "Carmen", "David", "Daniel", "Farah", "Ben", "Mia"
    ].map { Character(name: $0) }
}
