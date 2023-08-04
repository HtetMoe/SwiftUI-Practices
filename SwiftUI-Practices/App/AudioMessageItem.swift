//
//  AudioMessageItem.swift
//  AudioWaveform
//
//  Created by Hein Htoo Htoo Kyaw on 15/05/2023.
//

import SwiftUI
import AVFoundation
import UIKit

struct AudioMessageItem: View {
    var audioName: String
    var audioType  = "mp3"
    var isIncoming = false
    
    @State var audioPlayer: AVAudioPlayer!
    @State private var isPlaying: Bool = false
    
    @State var sliderValue: Double = 0.0
    
    @State var progress: CGFloat = 0.0
    @State var duration: Double  = 0.0
    @State var passedDuration : String = "00:00"
   
    let displayWidth : Double = 118
    
    var body: some View {
        
        HStack {
            Button {
                isPlaying.toggle()
                isPlaying ? startPlayback() : pausePlayback()
                
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            
            ZStack{
                //wave form
                AudioWaveFormView(track: audioName, format: audioType)
                    .overlay(alignment: .trailing) {
                        ZStack{}
                            .frame(maxWidth: displayWidth - (displayWidth * progress), maxHeight: .infinity)
                            .background(.green.opacity(0.5))
                    }
                
                //slider
//                Slider(value: Binding(
//                    get: {
//                        sliderValue
//                    },
//                    set: { newValue in
//                        sliderValue = newValue
//                        let time = sliderValue / displayWidth * duration
//                        audioPlayer.currentTime = time
//                    }
//                ), in: 0...displayWidth)
//                .accentColor(.clear)
//                .frame(width: displayWidth)
            }
            
            Text(passedDuration)
                .foregroundColor(.white)
                .font(.footnote)
                .multilineTextAlignment(.trailing)
                .frame(width: 40)
        }
        .padding()
        .background(.green)
        .cornerRadius(14)
        .onAppear {
            initialiseAudioPlayer()
        }
    }
    
    func startPlayback(){
        self.audioPlayer.play()
    }
    func pausePlayback(){
        self.audioPlayer.pause()
    }
      
    func initialiseAudioPlayer() {
        
        //format passed duration
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]

        //audioPlayer
        guard let audioURL = Bundle.main.path(forResource: audioName, ofType: audioType) else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioURL))
            self.audioPlayer.prepareToPlay()
            duration = self.audioPlayer.duration
            
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                if !audioPlayer.isPlaying {
                    isPlaying = false
                }
                progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
                passedDuration = formatter.string(from: TimeInterval(ceil(self.audioPlayer.duration - self.audioPlayer.currentTime)))!
                sliderValue    = Double(audioPlayer.currentTime / duration) * 118
            }
        }
        catch {
            print("Failed to start audio playback: \(error)")
        }
    }
}

struct AudioMessageItem_Previews: PreviewProvider {
    static var previews: some View {
        AudioMessageItem(audioName: "")
    }
}
