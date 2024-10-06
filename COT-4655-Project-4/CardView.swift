import SwiftUI
import Foundation

struct CardView: View {
    let content: String
    let isFaceUp: Bool
    let isMatched: Bool
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                if isFaceUp || isMatched {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                } else {
                    base.fill(.blue)
                }
            }
            .opacity(isMatched ? 0 : 1)
        }
        .animation(.easeInOut(duration: 1), value: isMatched)
    }
}

#Preview{
    ContentView()
}
