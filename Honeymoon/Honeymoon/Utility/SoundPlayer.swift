//
//  SoundPlayer.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/9/23.
//

import AVFoundation

class SoundPlayer {
    static let shared = SoundPlayer()
    private init() {}
    
    var player: AVAudioPlayer?
    
    func playSound(sound: String, type: String) {
        guard let path = Bundle.main.path(forResource: sound, ofType: type) else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        } catch {
            print("ERROR: Could not locate the sound file.")
        }
    }
}
