//
//  DownloadClient.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 26/07/2023.
//  This is for testing end points and mock data

import Foundation
import SwiftUI

protocol SessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class DownloadClient : ObservableObject{
    @Published var uiImage : UIImage?
    
    var session : SessionProtocol = URLSession.shared
    
    func downloadImage(withURL url: String) {
        guard let url = URL(string: url) else { fatalError("Invalid URL!") }
        session.dataTask(with: url) { (data, response, error) in
            //code to create image
            if error != nil {
                debugPrint("Failed : \(String(describing: error?.localizedDescription))")
                return
            }
            DispatchQueue.main.async {
                self.uiImage     = UIImage(data: data!)
            }
        }.resume()
    }
    
    func terribleFunctionYouWouldNeverWrite() {
        let totalValue = 1000000
        var currentValue = 0
        for i in 1...totalValue {
            currentValue = i
        }
    }
    
}

extension URLSession: SessionProtocol {}
