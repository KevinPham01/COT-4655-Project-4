import SwiftUI


struct CardGridView: View {
    // Define two flexible columns for the buttons
    let buttonColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Define three flexible columns for the cards
    let cardColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            // Add the buttons at the top
            LazyVGrid(columns: buttonColumns, spacing: 20) {
                Button("Choose Size") {
                    // Add action here
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Reset Game") {
                    // Add action here
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()

            // Card grid
            ScrollView {
                LazyVGrid(columns: cardColumns, spacing: 10) {
                    ForEach(0..<12) { index in
                        CardView(index: index)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

// Assuming you have a CardView struct defined elsewhere
struct CardView: View {
    let index: Int
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
    }
}
