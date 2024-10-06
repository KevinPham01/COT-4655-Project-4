import SwiftUI

// Define the custom alignment outside of ContentView
private enum CustomVerticalAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.height / 2
    }
}

extension VerticalAlignment {
    static let custom = VerticalAlignment(CustomVerticalAlignment.self)
}

struct ContentView: View {
    @State private var emojis = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🥝", "🍍"]
    @State private var selectedPairs = 6
    @State private var openCardIndexes: Set<Int> = []
    @State private var matchedCardIndexes: Set<Int> = []
    @State private var shuffledIndices: [Int] = []
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Menu {
                    Button("3 Pairs") { resetGame(pairs: 3) }
                    Button("6 Pairs") { resetGame(pairs: 6) }
                    Button("10 Pairs") { resetGame(pairs: 10) }
                } label: {
                    Text("Choose Size")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
                Spacer()
                
                Button(action: {
                    resetGame(pairs: selectedPairs)
                }) {
                    Text("Reset Game")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 59)
            
            Text("\(selectedPairs) Pairs")
                .padding(.top, 10)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(0..<(selectedPairs * 2), id: \.self) { index in
                        CardView(content: emojis[safeIndex(index)],
                                 isFaceUp: openCardIndexes.contains(index) || matchedCardIndexes.contains(index),
                                 isMatched: matchedCardIndexes.contains(index))
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    cardTapped(index)
                                }
                            }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            resetGame(pairs: selectedPairs)
        }
    }
    
    private func safeIndex(_ index: Int) -> Int {
        guard !shuffledIndices.isEmpty else { return 0 }
        return shuffledIndices[index % shuffledIndices.count] % selectedPairs
    }
    
    func resetGame(pairs: Int) {
        selectedPairs = pairs
        emojis.shuffle()
        openCardIndexes.removeAll()
        matchedCardIndexes.removeAll()
        shuffledIndices = Array(0..<(pairs * 2)).shuffled()
    }
    
    func cardTapped(_ index: Int) {
        if !openCardIndexes.contains(index) && !matchedCardIndexes.contains(index) {
            if openCardIndexes.count == 2 {
                openCardIndexes.removeAll()
            }
            
            openCardIndexes.insert(index)
            
            if openCardIndexes.count == 2 {
                let openCards = Array(openCardIndexes)
                if safeIndex(openCards[0]) == safeIndex(openCards[1]) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        matchedCardIndexes.formUnion(openCardIndexes)
                    }
                    openCardIndexes.removeAll()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            openCardIndexes.removeAll()
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
