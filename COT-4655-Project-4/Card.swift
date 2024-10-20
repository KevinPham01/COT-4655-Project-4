import Foundation

struct Card: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}
