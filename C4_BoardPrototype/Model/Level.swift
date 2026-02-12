//
//  Level.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//

import Foundation

/// Represents a single stage in the "Query Combat: Detroit" journey.
/// Conforms to Identifiable to allow easy iteration in SwiftUI Views.
struct Level: Identifiable {
    /// Unique identifier for the level, used as the sequence on the game board.
    let id: Int
    
    /// The trivia or logic question presented to the player.
    let question: String
    
    /// A collection of possible answers displayed as choices in the UI.
    let options: [String]
    
    /// The string value that must match the user's selection to progress.
    let correctAnswer: String
    
    /// Tracks if the player has reached this level on the road.
    var isUnlocked: Bool
    
    /// Tracks if the level has been successfully answered. Defaults to false.

    var isCompleted: Bool = false
}
