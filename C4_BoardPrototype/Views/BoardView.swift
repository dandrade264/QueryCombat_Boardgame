//
//  BoardView.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//

import SwiftUI

/// The main game map where players progress through Detroit-themed levels.
struct BoardView: View {
    // MARK: - Properties
    
    /// The 'Brain' of the game session, managing levels and scoring.
    @State private var viewModel = GameViewModel()
    
    /// Injected closure to return the user to the splash screen.
    let onExitToTitle: () -> Void
    
    /// Controls the vertical 'hover' animation for the active player marker.
    @State private var ratBob = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background & Environment
                Color.black.ignoresSafeArea()
                
                // The Motor City Road: Visual connector for level nodes.
                ZStack {
                    Rectangle() // Road surface
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 1400, height: 35)
                    
                    Rectangle() // Yellow dashed safety lines
                        .stroke(Color.yellow.opacity(0.8), style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [15, 20]))
                        .frame(width: 1400, height: 2)
                }
                .offset(y: 65) // Aligns road to the center of the level nodes
                
                // MARK: - Level Progression Path
                HStack(spacing: 110) {
                    ForEach(viewModel.levels) { level in
                        VStack(spacing: 10) {
                            
                            // Active Player Marker (The Rat)
                            if level.isUnlocked && !level.isCompleted {
                                Image("Rat_Icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 140, height: 140)
                                    .offset(y: ratBob ? -12 : 0)
                                    .onAppear {
                                        // Infinite bobbing animation to make the mascot feel alive.
                                        withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                                            ratBob = true
                                        }
                                    }
                            } else {
                                // Keeps the layout stable when the rat isn't present.
                                Color.clear.frame(width: 140, height: 140)
                            }

                            // Individual Level Node
                            NodeView(level: level) {
                                viewModel.selectedLevel = level
                            }
                        }
                    }
                }
            }
            // MARK: - Overlays (Questions & Victory)
            
            // Presents the quiz interface when a level is selected.
            .fullScreenCover(item: $viewModel.selectedLevel) { level in
                QuestionView(level: level, status: viewModel.answerStatus) { userAnswer in
                    viewModel.checkAnswer(userAnswer)
                }
            }
            // Presents the end-game screen upon completion.
            .fullScreenCover(isPresented: $viewModel.isGameComplete) {
                VictoryView(
                    onPlayAgain: { viewModel.resetGame() },
                    onExit: {
                        viewModel.isGameComplete = false
                        onExitToTitle()
                    }
                )
            }
        }
    }
}

// MARK: - Subviews

/// A standalone component representing a single interactive level on the map.
struct NodeView: View {
    let level: Level
    let action: () -> Void
    @State private var isPulsing = false
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Pulse effect to draw attention to the current playable level.
                if level.isUnlocked && !level.isCompleted {
                    Circle()
                        .stroke(Color.yellow, lineWidth: 5)
                        .scaleEffect(isPulsing ? 1.15 : 1.0)
                        .opacity(isPulsing ? 0.0 : 0.7)
                }
                
                // Main Level Node: Uses specific sizing to fit tvOS 'Glow' effects.
                Circle()
                    .fill(level.isUnlocked ? Color.yellow : Color.gray.opacity(0.4))
                    .frame(width: 150, height: 150)
                
                // Visual indicators for level state: Lock, Checkmark, or ID Number.
                if !level.isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 45))
                        .foregroundColor(.white.opacity(0.5))
                } else if level.isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 55, weight: .bold))
                        .foregroundColor(.black)
                } else {
                    Text("\(level.id)")
                        .font(.system(size: 65, weight: .black))
                        .foregroundColor(.black)
                }
            }
        }
        .buttonStyle(.card) // Enables the native tvOS tilt/parallax effect.
        .disabled(!level.isUnlocked)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                isPulsing = true
            }
        }
    }
}
#Preview {
    BoardView(onExitToTitle: {
        print("BoardView: Exit to Title tapped")
    })
}
