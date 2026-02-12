//
//  TitleView.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/11/26.
//

import SwiftUI

/// The initial landing screen for the game.
/// Sets the visual and atmospheric tone for the Detroit Edition.
struct TitleView: View {
    /// A closure triggered when the user selects 'Enter the Arena'.
    /// Handled by the App entry point to swap views.
    let onStart: () -> Void
    
    var body: some View {
        ZStack {
            // High-contrast background for better visibility in living room settings
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 50) {
                // MARK: - Branding
                
                // Displaying the custom team logo with a subtle shadow for depth
                Image("QC_Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 320)
                    .shadow(color: .black.opacity(0.5), radius: 30)
                
                VStack(spacing: 15) {
                    Text("QUERY COMBAT")
                        .font(.system(size: 140, weight: .black))
                    
                    Text("DETROIT EDITION")
                        .font(.system(size: 40, weight: .semibold, design: .monospaced))
                        .foregroundColor(.yellow)
                        .tracking(8) // Adds industrial-style spacing between letters
                }
                .foregroundColor(.white)
                
                // MARK: - Navigation
                
                // Big CTA: Designed for the Apple TV remote 'Focus' state
                Button(action: onStart) {
                    Text("ENTER THE ARENA")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 60)
                }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    // We provide an empty closure { } because the preview
    // just needs to show the UI, not actually switch screens.
    TitleView(onStart: {
        print("TitleView: Enter the Arena tapped")
    })
}
