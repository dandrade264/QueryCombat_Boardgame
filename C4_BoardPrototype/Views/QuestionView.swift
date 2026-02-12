//
//  QuestionView.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//

import SwiftUI

/// The interactive quiz interface where players engage with Detroit trivia.
/// Features dynamic visual feedback based on the player's performance.
struct QuestionView: View {
    let level: Level
    let status: AnswerStatus
    let onAnswer: (String) -> Void
    
    var body: some View {
        ZStack {
            // MARK: - Background Layer
            Color.black.opacity(0.95).ignoresSafeArea()
            
            // Faint watermark branding for environmental depth
            Image("QC_Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .opacity(0.05)
            
            VStack(spacing: 60) {
                // Header: Level Indicator using the Detroit industrial font style
                Text("LEVEL \(level.id)")
                    .font(.headline)
                    .tracking(10)
                    .foregroundColor(status == .incorrect ? .red : .yellow.opacity(0.7))
                
                // MARK: - Question Card
                Text(level.question)
                    .font(.system(size: 70, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(60)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(borderColor, lineWidth: 10)
                            // Glow intensity increases on success or failure
                            .shadow(color: borderColor.opacity(status == .neutral ? 0 : 1), radius: 30)
                    )
                    // Custom shake animation triggered by incorrect state
                    .modifier(Shake(animatableData: status == .incorrect ? 1 : 0))
                    .animation(.spring(), value: status)
                
                // MARK: - Answer Selection
                HStack(spacing: 40) {
                    ForEach(level.options, id: \.self) { option in
                        AnswerButton(text: option) {
                            onAnswer(option)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// Determines the border and glow color based on current Game State.
    private var borderColor: Color {
        switch status {
        case .neutral: return .blue.opacity(0.3)
        case .correct: return .green
        case .incorrect: return .red
        }
    }
}

// MARK: - Supporting Views

/// A custom-styled button providing tactile feedback for tvOS users.
struct AnswerButton: View {
    let text: String
    let action: () -> Void
    
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                isPressed = true
            }
            
            // Short delay ensures the 'Squish' animation is seen before the view dismisses
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isPressed = false
                action()
            }
        }) {
            Text(text)
                .font(.title2)
                .frame(minWidth: 350, minHeight: 120)
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue.opacity(0.2))
        .scaleEffect(isPressed ? 0.85 : 1.0)
    }
}

// MARK: - Animation Modifiers

/// A specialized geometry effect that creates a horizontal shake.
/// Used to provide immediate feedback for incorrect answers.
struct Shake: GeometryEffect {
    var amount: CGFloat = 15
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
