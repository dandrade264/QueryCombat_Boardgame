//
//  C4_BoardPrototypeApp.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//

import SwiftUI

/// The entry point for 'Query Combat: Detroit Edition'.
/// Manages the top-level navigation state and global services like Audio.
@main
struct C4_BoardPrototypeApp: App {
    
    // MARK: - App State
    
    /// Controls whether the user is viewing the Title Screen or the Game Board.
    /// Initialized to 'false' to ensure the splash screen is the first experience.
    @State private var hasStartedGame = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if hasStartedGame {
                    // Injecting the closure to allow BoardView to 'call back' to the App level.
                    BoardView(onExitToTitle: {
                        hasStartedGame = false
                    })
                } else {
                    // Start button triggers the transition to the game board.
                    TitleView(onStart: {
                        hasStartedGame = true
                    })
                }
            }
            .onAppear {
                // MARK: - Global Initialization
                
                // Triggers the background music as soon as the app window is ready.
                AudioManager.shared.startBackgroundMusic()
            }
        }
    }
}
