//
//  ImageUrlViewModel.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 26/07/2023.
//

import Foundation
import SwiftUI

class ImageUrlViewModel : ObservableObject {
    @Published var uiImage : UIImage?
    var imageCache : NSCache<AnyObject, AnyObject> = NSCache()
    
    //load image
    func downloadImage(urlString : String){
        guard let url = URL(string: urlString) else { return }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.uiImage = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                debugPrint("Failed : \(String(describing: error?.localizedDescription))")
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                self.uiImage     = imageToCache
                self.imageCache.setObject(self.imageCache, forKey: url.absoluteString as AnyObject)
            }
        }
        .resume()
    }
}
