//
//  AudioManager.swift
//  C4_BoardPrototype
//
//  Created by Daniel Andrade on 2/12/26.
//

import AVFoundation

/// Handles background music playback for the entire application.
/// Uses a Singleton pattern for consistent audio across all screens.
class AudioManager {
    /// Global shared instance to access audio controls anywhere in the app.
    static let shared = AudioManager()
    
    /// The underlying player for the soundtrack.
    var player: AVAudioPlayer?

    /// Configures and starts the background loop.
    func startBackgroundMusic() {
        // Look for the soundtrack in the main project bundle
        guard let url = Bundle.main.url(forResource: "QueryCombatLoop", withExtension: "mp3") ??
                        Bundle.main.url(forResource: "QueryCombatLoop", withExtension: nil) else {
            print("🔊 Audio Error: Could not find QueryCombatLoop in the project bundle.")
            return
        }

        do {
            // Configure the audio session to play even if the device is on 'Silent'
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            
            // Set to -1 to loop the GarageBand track indefinitely
            player?.numberOfLoops = -1
            
            // Volume level (0.0 to 1.0)
            player?.volume = 0.5
            
            player?.prepareToPlay()
            player?.play()
            
            print("🎵 Music started successfully!")
        } catch {
            print("🔊 Audio Error: \(error.localizedDescription)")
        }
    }
    
    /// Stops the music (useful for game transitions or settings).
    func stopMusic() {
        player?.stop()
    }
}
