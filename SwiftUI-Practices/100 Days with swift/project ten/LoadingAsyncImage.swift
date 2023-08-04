//
//  LoadingAsyncImage.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 11/07/2023.
//

import SwiftUI

struct LoadingAsyncImage: View {
    
    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) with 3x
       
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        
        //complete format
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
    }
}

struct LoadingAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAsyncImage()
    }
}
