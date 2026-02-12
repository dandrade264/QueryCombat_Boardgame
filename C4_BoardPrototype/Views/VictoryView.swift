//
//  VictoryView.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//

import SwiftUI

/// The final celebratory screen displayed upon completing all levels.
/// Uses closures to delegate game logic back to the BoardView.
struct VictoryView: View {
    // MARK: - Navigation Closures
    
    /// Triggered to reset the game state and return to Level 1.
    let onPlayAgain: () -> Void
    
    /// Triggered to return the user to the initial splash screen.
    let onExit: () -> Void
    
    var body: some View {
        VStack(spacing: 60) {
            // MARK: - Hero Icon
            
            // Large trophy icon with a 'Neon' Detroit glow effect
            Image(systemName: "trophy.fill")
                .font(.system(size: 220))
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.5), radius: 40)
            
            // MARK: - Victory Text
            
            VStack(spacing: 20) {
                Text("DETROIT CONQUERED")
                    .font(.system(size: 95, weight: .black))
                    .foregroundColor(.white)
                
                Text("You've mastered Query Combat - Detroit Edition!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .tracking(2)
            }
            
            // MARK: - Action Buttons
            
            HStack(spacing: 50) {
                // Primary Action: Prominent style signals this is the next logical step
                Button(action: onPlayAgain) {
                    Text("Play Again")
                        .padding(.horizontal, 40)
                }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                .foregroundColor(.black)
                
                // Secondary Action: Bordered style for a less "heavy" visual weight
                Button(action: onExit) {
                    Text("Exit to Title")
                        .padding(.horizontal, 40)
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.95).ignoresSafeArea())
    }
}
