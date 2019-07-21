//
//  SoundManager.swift
//  Morning
//
//  Created by Capucine Chatard on 7/7/19.
//  Copyright © 2019 Capucine Chatard. All rights reserved.
//

import AVFoundation
import AudioToolbox

struct SoundManager {
    var player: AVAudioPlayer?
    
   func initializePlayer(sound: String) -> AVAudioPlayer? {
    guard let path = Bundle.main.path(forResource: "\(sound)", ofType: "wav") else {
            return nil
        }
        
        return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
    }
    
    mutating func playPlayer(wavSound: String) {
        player = initializePlayer(sound: wavSound)
    player?.play()
}
}
