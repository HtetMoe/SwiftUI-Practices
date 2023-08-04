//
//  AudioWaveFormView.swift
//  AudioWaveform
//
//  Created by Hein Htoo Htoo Kyaw on 15/05/2023.
//

import SwiftUI
import AVFoundation

struct AudioWaveFormView: View {
    var track : String
    var format: String = "mp3"
    
    var body: some View {
       
        HStack(spacing: 2) {
            ForEach(getAmplitude(track: track, format: format), id: \.self) { value in
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 2, height: CGFloat((value * 100)) + 2)
                    .cornerRadius(2)
            }
        }
        .onAppear{
            guard let audioURL = URL(string: "https://galaxyshopbucket.s3.ap-southeast-1.amazonaws.com/CHAT_MESSAGE/a40943d1-1c65-48cd-aa4d-f04175a7c023-airplane-landing_daniel_simion.mp3") else {
                
                print("Failed to load URL")
                
                return
            }
            
            URLSession.shared.dataTask(with: audioURL) { (data, response, error) in
                guard let audioData = data else {
                    print("Failed to load Audio Data")
                    return
                }
                
                let sampleSize = MemoryLayout<Int16>.size
                let sampleCount = audioData.count / sampleSize
                var amplitudes : [Float]  = []
                
                audioData.withUnsafeBytes { (bufferPointer: UnsafeRawBufferPointer) in
                    let audioBuffer = bufferPointer.bindMemory(to: Int16.self)
                    for i in 0..<sampleCount {
                        let sample = audioBuffer[i]
                        let amplitude = Float(sample) / Float(Int16.max)
                        //print("Amplitude at index \(i): \(amplitude)")
                        amplitudes.append(amplitude)
                    }
                }
                print("amplitude count : \(amplitudes.count)")
                
            }.resume()
        }
    }
}


//MARK: - from local audio file
func getAmplitude(track: String, format: String) -> [CGFloat] {
    var amplitudes : [CGFloat] = []
    do {
        guard let path = Bundle.main.url(forResource: track, withExtension: format) else { return amplitudes}
        let audioFile = try AVAudioFile(forReading: path)
        let format = audioFile.processingFormat

        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: UInt32(audioFile.length)) else { return amplitudes}

        try audioFile.read(into: buffer)

        let floatArray = Array(UnsafeBufferPointer(start: buffer.floatChannelData?[0], count:Int(buffer.frameLength)))

        for sample in floatArray {
            let amplitude = abs(sample)
            // Do something with the amplitude value
            amplitudes.append(CGFloat(amplitude))
        }
    } catch {
        // Handle the error
        print("An error occurred: \(error.localizedDescription)")
    }
    if (amplitudes.count > 30) {
        amplitudes = summarizeAmplitudeArray(amplitudes, toLength: 30)
    }
    //print(amplitudes)
    return amplitudes
}

func summarizeAmplitudeArray(_ amplitudeArray: [CGFloat], toLength length: Int) -> [CGFloat] {
    let step = amplitudeArray.count / length
    var summarizedArray = [CGFloat]()
    for i in 0..<length {
        var sum = 0.0
        for j in (i*step)..<((i+1)*step) {
            sum += amplitudeArray[j]
        }
        summarizedArray.append(sum / CGFloat(step))
    }
    return summarizedArray
}

struct AudioWaveFormView_Previews: PreviewProvider {
    static var previews: some View {
        AudioWaveFormView(track: "")
    }
}
