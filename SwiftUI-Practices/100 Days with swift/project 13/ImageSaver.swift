//
//  ImageSaver.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 21/07/2023.
//

import Foundation
import SwiftUI

class ImageSaver : NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
