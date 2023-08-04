//
//  FilePreviewDemo.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/03/2023.
//

import SwiftUI

struct FilePreviewDemo: View {
    
    @State var pdfFileURL = URL(string: "https://galaxyshopbucket.s3.ap-southeast-1.amazonaws.com/CHAT_MESSAGE/a9d7a5b7-26d2-4ad1-bc8e-39723ef2042f_sample.pdf")
    
    @State var textFileURL = URL(string: "https://galaxyshopbucket.s3.ap-southeast-1.amazonaws.com/CHAT_MESSAGE/1e082436-7e99-4452-ac70-aadbea5440f1_youknow%20modification.txt")
    
    @State var showPreview = false
    
    var body: some View {
        VStack{
            let fileName = "\(pdfFileURL?.lastPathComponent ?? "Unknown file!")"
            
            Text("\(fileName)")
                .fontWeight(.semibold)
                .padding()
                .onTapGesture {
                    self.showPreview.toggle()
                }
        }
        .fullScreenCover(isPresented: $showPreview) {
            AnyFileTypePreview(url: $pdfFileURL)
        }
    }
}

struct FilePreviewDemo_Previews: PreviewProvider {
    static var previews: some View {
        FilePreviewDemo()
    }
}

