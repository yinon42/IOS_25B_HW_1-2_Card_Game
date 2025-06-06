//
//  SoundManager.swift
//  IOS_25B_HW1&2
//
//  Created by Student21 on 25/05/2025.
//


import AVFoundation

class SoundManager {
    static let shared = SoundManager()

    private var player: AVAudioPlayer?
    private var backgroundPlayer: AVAudioPlayer?

    func playSound(named name: String) {
        print("🔊 Trying to play sound: \(name).mp3")
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("❌ Sound file \(name).mp3 not found in bundle")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("✅ Playing sound: \(name).mp3")
        } catch {
            print("❌ Failed to play \(name): \(error.localizedDescription)")
        }
    }

    func playBackgroundMusic() {
        print("🎵 Starting background music")
        guard let url = Bundle.main.url(forResource: "game_background_music", withExtension: "mp3") else {
            print("❌ Background music file not found")
            return
        }

        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.play()
            print("✅ Background music playing")
        } catch {
            print("❌ Background music error: \(error.localizedDescription)")
        }
    }

    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
        print("⏹️ Background music stopped")
    }
}
