//
//  ImageUrlView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 26/07/2023.
//

import SwiftUI

struct ImageUrlView: View {
    @StateObject private var viewModel = ImageUrlViewModel()
    
    var body: some View {
        
        ZStack{
            if let image = viewModel.uiImage{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else{
                Color.gray.frame(width: 100, height: 100)
            }
        }
        .onAppear{
            let urlString = "https://media.licdn.com/dms/image/D4D03AQEG95jXAuhqeQ/profile-displayphoto-shrink_800_800/0/1690207995167?e=1695859200&v=beta&t=CZOd6MLdyPamOYD78X2uuV3W3mCTRwM_LMMg7uZiEUw"
            viewModel.downloadImage(urlString: urlString)
        }
    }
}

struct ImageUrlView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUrlView()
    }
}
