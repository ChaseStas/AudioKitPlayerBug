//
//  ContentView.swift
//  AudioKitBugDemo
//
//  Created by Chase on 7.05.21.
//

import SwiftUI
import AudioKit

class Conductor {
    private let engine = AudioEngine()
    private let player: AudioPlayer
    private let player2: AudioPlayer

    init() {
        player = AudioPlayer(url: Bundle.main.url(forResource: "Beat", withExtension: "mp3")!)!
        player2 = AudioPlayer(url: Bundle.main.url(forResource: "Beat", withExtension: "mp3")!, buffered: true)!
        engine.output = Mixer(player, player2)
        try? Settings.setSession(category: .playback)
        try? engine.start()
    }

    func playBuffered() {
        player2.play()
    }
    func stopBuffered() {
        player2.stop()
    }

    func playNormal() {
        player.play()
    }
    func stopNormal() {
        player.stop()
    }
}

struct ContentView: View {
    let conductor = Conductor()

    var body: some View {
        HStack {
            VStack {
                Text("Buffered beat")
                Button(action: {
                    conductor.playBuffered()
                }, label: {
                    Text("Play")
                })
                Button(action: {
                    conductor.stopBuffered()
                }, label: {
                    Text("Stop")
                })
            }

            VStack {
                Text("Not buffered beat")
                Button(action: {
                    conductor.playNormal()
                }, label: {
                    Text("Play")
                })
                Button(action: {
                    conductor.stopNormal()
                }, label: {
                    Text("Stop")
                })
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
