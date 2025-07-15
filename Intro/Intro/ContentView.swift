//
//  ContentView.swift
//  Intro
//
//  Created by Joe L Barr on 1/17/24.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "beep-08b", withExtension: ".wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Play sound") {
                SoundManager.instance.playSound()
            }
        }
    }
}

#Preview {
    ContentView()
}
