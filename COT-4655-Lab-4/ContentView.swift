//
//  ContentView.swift
//  COT-4655-Lab-4
//
//  Created by Kevin Pham on 10/4/24.
//

// Import the SwiftUI framework in any file you want to use SwiftUI
import SwiftUI

// Define the ContentView structure, which conforms to the View protocol
struct ContentView: View {
    // Define the body property, required by the View protocol
    // Return any object that conforms to the View protocol
    @State private var cards: [Card] = Card.mockedCards

    @State private var cardsToPractice: [Card] = [] // <-- Store cards removed from cards array
    @State private var cardsMemorized: [Card] = []
    @State private var deckId: Int = 0
    @State private var createCardViewPresented = false

    var body: some View {
        // Vertical stack (VStack) to arrange views vertically

        ZStack {

            // Reset buttons
            VStack { // <-- VStack to show buttons arranged vertically behind the cards
               Button("Reset") { // <-- Reset button with title and action
                   cards = cardsToPractice + cardsMemorized // <-- Reset the cards array with cardsToPractice and cardsMemorized
                   cardsToPractice = [] // <-- set both cardsToPractice and cardsMemorized to empty after reset
                   cardsMemorized = [] // <--
                   deckId += 1 // <-- Increment the deck id

               }
               .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)

               Button("More Practice") { // <-- More Practice button with title and action
                   cards = cardsToPractice // <-- Reset the cards array with cardsToPractice
                   cardsToPractice = [] // <-- Set cardsToPractice to empty after reset
                   deckId += 1 // <-- Increment the deck id

               }
               .disabled(cardsToPractice.isEmpty)
           }
            
            ForEach(0..<cards.count, id: \.self) { index in
                CardView(card: cards[index], onSwipedLeft: {
                    let removedCard = cards.remove(at: index) // <-- Get the removed card
                    cardsToPractice.append(removedCard) // <-- Add removed card to cards to practice array
                }, onSwipedRight: {
                    let removedCard = cards.remove(at: index) // <-- Get the removed card
                    cardsMemorized.append(removedCard) // <-- Add removed card to memorized cards array
                })
                    .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))

            }
        }
        .animation(.bouncy, value: cards)
        .id(deckId) //<-- Add an id modifier to the main card deck ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- Force the ZStack frame to expand as much as possible (the whole screen in this case)
        .overlay(alignment: .topTrailing) {
            Button("Add Flashcard", systemImage: "plus") {
                createCardViewPresented.toggle()
            }
        }
        .sheet(isPresented: $createCardViewPresented, content: {
            CreateFlashcardView { card in
                cards.append(card)
            }
        })
    }
            


            // Text view displaying the "Hello, world!" string
    

        
    }


// Preview the ContentView in the canvas
#Preview {
    ContentView()
}
