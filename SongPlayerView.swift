////
////  AudioPlayerDemo.swift
////  MyCodes
////
////  Created by Htet Moe Phyu on 12/05/2023.
////
//
//import SwiftUI
//import AVFoundation
//import AVKit
//
//struct SongPlayerView: View {
//    @State var progressWidth: CGFloat = 158 {
//        didSet{
//            //print(progressWidth)
//        }
//    }
//    @State private var isPlaying = false
//    @State private var audioPlayer: AVAudioPlayer?
//    @State private var timer: Timer?
//    
//    @State private var sliderValue: Double = 0.0{
//        didSet{
////            print("sliderValue : \(sliderValue)")
//        }
//    }
//
//    var body: some View {
//        HStack {
//            
//            Spacer()
//            
//            HStack {
//                Button {
//                    isPlaying.toggle()
//                    if isPlaying {
//                        startPlayback()
//                    } else {
//                        pausePlayback()
//                    }
//                    
//                } label: {
//                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
//                }
//                
//                ZStack(alignment: .trailing) {
//                    
//                    HStack(spacing: 2) {
//                        ForEach(getAmplitude(), id: \.self) { value in
//                            Rectangle()
//                                .fill(.white)
//                                .frame(width: 2, height: (value * 80) + 2)
//                                .cornerRadius(2)
//                        }
//                    }
//                    
//                    ZStack{}
//                        .frame(width: progressWidth, height: 40, alignment: .trailing)
//                        .background(.green)
//                        .opacity(0.5)
//                        .animation(isPlaying ? .linear(duration: 0.1) : nil, value: isPlaying)
//                    
//                    Slider(value: $sliderValue, in: 0...158, onEditingChanged:{ isEditing in
//                        if !isEditing{
//                            seekToTime()
//                        }
//                    })
//                    .accentColor(.white)
//                    .frame(width: 158)
//                }
//                .frame(height: 40)
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 8)
//            .background(.green)
//            .cornerRadius(14)
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 8)
//    }
//    
//    func startPlayback() {
//        if let player = audioPlayer, player.isPlaying == false {
//            // Resume playback if audioPlayer exists and is paused
//            player.play()
//            
//            sliderValue = player.currentTime
//        } else {
//            // Start playback from the beginning
//            guard let audioURL = Bundle.main.url(forResource: "hello", withExtension: "mp3") else { return }
//            
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
//                audioPlayer?.play()
//                
//                // Start the timer to update the progress
//                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//                    updateProgress()
//                    print("progress width : \(progressWidth)")
//                }
//            } catch {
//                print("Failed to start audio playback: \(error)")
//            }
//        }
//    }
//    
//    // Stop audio playback
//    func pausePlayback() {
//        audioPlayer?.pause()
//        
//        // Invalidate the timer
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func updateProgress() {
//        guard let player = audioPlayer else { return }
//        
//        let currentTime = CGFloat(player.currentTime)
//        let totalTime = CGFloat(player.duration)
//     
//        if totalTime > 0 {
//            let progress = currentTime / totalTime
//        
//            let newProgressWidth = progress * 158 //progress * 158 // Adjust the total width as needed
//            
//            if progressWidth != newProgressWidth {
//                if isPlaying {
//                    withAnimation {
//                        progressWidth = newProgressWidth
//                    }
//                } else {
//                    progressWidth = newProgressWidth
//                }
//                
//                sliderValue = newProgressWidth // update slider
//            }
//            else{
//                print("completed")
//                DispatchQueue.main.async {
//                    self.isPlaying = false
//                }
//            }
//        }
//    }
//    
//    func seekToTime() {
//        guard let player = audioPlayer else { return }
//        player.currentTime = sliderValue
//        if isPlaying {
//            player.play()
//        }
//        else{
//            player.pause()
//        }
//    }
//    
//}
//
//
////MARK: - amplitude from File
//func getAmplitude() -> [CGFloat] {
//    var amplitudes : [CGFloat] = []
//    do {
//        guard let path = Bundle.main.url(forResource: "hello", withExtension: "mp3") else { return amplitudes}
//        let audioFile = try AVAudioFile(forReading: path)
//        let format = audioFile.processingFormat
//        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: UInt32(audioFile.length)) else { return amplitudes}
//        try audioFile.read(into: buffer)
//        let floatArray = Array(UnsafeBufferPointer(start: buffer.floatChannelData?[0], count:Int(buffer.frameLength)))
//
//        for sample in floatArray {
//            let amplitude = abs(sample)
//            // Do something with the amplitude value
//            amplitudes.append(CGFloat(amplitude))
//        }
//    } catch {
//        // Handle the error
//        print("An error occurred: \(error.localizedDescription)")
//    }
//    if (amplitudes.count > 40) {
//        amplitudes = summarizeAmplitudeArray(amplitudes, toLength: 40)
//    }
//    //print(amplitudes)
//    return amplitudes
//}
//
