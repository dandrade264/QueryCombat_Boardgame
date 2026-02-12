//
//  GameViewModel.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//
import Foundation
import Observation

/// Defines the visual feedback state for the QuestionView.
enum AnswerStatus {
    case neutral, correct, incorrect
}

/// The 'Brain' of the game. Manages the state, logic, and progression of Query Combat.
@Observable
class GameViewModel {
    
    //Data Source
    
    /// The source of truth for all levels. Centralizing this here allows for easy content updates.
    var levels: [Level] = [
        Level(id: 1, question: "Detroit is known as the ___ City.", options: ["Windy", "Motor", "Emerald", "Forest"], correctAnswer: "Motor", isUnlocked: true),
        Level(id: 2, question: "Which river separates Detroit from Windsor?", options: ["Hudson", "Mississippi", "Detroit", "St. Lawrence"], correctAnswer: "Detroit", isUnlocked: false),
        Level(id: 3, question: "What year was the city of Detroit founded?", options: ["1601", "1701", "1801", "1901"], correctAnswer: "1701", isUnlocked: false)
    ]
    
    //Game State
    
    /// The level currently being played. When nil, the player is on the BoardView.
    var selectedLevel: Level?
    
    /// Controls the visual feedback (shake/glow) in the QuestionView.
    var answerStatus: AnswerStatus = .neutral
    
    /// Triggered when the final level is successfully completed.
    var isGameComplete: Bool = false
    
    // Game Logic
    
    /// Validates the player's choice and manages the transition timing.
    /// - Parameter selectedAnswer: The string value selected by the player.

    func checkAnswer(_ selectedAnswer: String) {
        guard let level = selectedLevel else { return }
        
        if selectedAnswer == level.correctAnswer {
            handleCorrectAnswer(for: level)
        } else {
            handleIncorrectAnswer()
        }
    }
    
    private func handleCorrectAnswer(for level: Level) {
        answerStatus = .correct
        // Delay ensures the player sees the "Success" state before the view dismisses
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.unlockNextLevel(after: level.id)
            self.selectedLevel = nil
            self.answerStatus = .neutral
        }
    }
    
    private func handleIncorrectAnswer() {
        answerStatus = .incorrect
        // Reset to neutral after the 'Shake' animation finishes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.answerStatus = .neutral
        }
    }
    
    //Progression & Reset
    /// Updates level status and checks for win conditions.
    private func unlockNextLevel(after currentID: Int) {
        if let index = levels.firstIndex(where: { $0.id == currentID }) {
            levels[index].isCompleted = true
            
            let nextIndex = index + 1
            if nextIndex < levels.count {
                levels[nextIndex].isUnlocked = true
            } else {
                self.isGameComplete = true
            }
        }
    }
    
    /// Restores the game to its initial state for a fresh play-through.
    func resetGame() {
        isGameComplete = false
        for i in 0..<levels.count {
            levels[i].isCompleted = false
            levels[i].isUnlocked = (i == 0) // Only level 1 starts unlocked
        }
    }
}
