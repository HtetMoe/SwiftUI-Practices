//
//  CoreImage.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 20/07/2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImage: View {
    @State private var image: Image?
    
    var body: some View {
        
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadSepiaFilterImage)
    }
    
    //a sepia effect applied image
    func loadSepiaFilterImage() {
        
        //input image
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity  = 1
        
        //output image, get ciImage from filter
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimage =  context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimage)
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImage_Previews: PreviewProvider {
    static var previews: some View {
        CoreImage()
    }
}
