//
//  COT_4655_Lab_4App.swift
//  COT-4655-Lab-4
//
//  Created by Kevin Pham on 10/4/24.
//

import SwiftUI

// The @main attribute indicates that FlashcardStarterApp is the entry point for the app.
@main
struct FlashcardStarterApp: App {
    // The 'body' property is required for any SwiftUI App. It defines the content of the app.
    var body: some Scene {
        // A Scene represents a single user interface within the app.
        WindowGroup {
            // The WindowGroup represents the main window of the app.
            ContentView()
            // ContentView is the main view or the root view of the app.
            // This is where you start defining the structure and content of your app's user interface.
        }
    }
}
