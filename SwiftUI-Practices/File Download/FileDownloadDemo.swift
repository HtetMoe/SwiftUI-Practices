//
//  FileDownloadDemo.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 20/03/2023.

import SwiftUI
import UIKit

struct FileDownloadDemo: View {
    @StateObject var fileDownloadModel = FileDownloadTaskModel()
    @State var fileUrlString : String = "https://galaxyshopbucket.s3.ap-southeast-1.amazonaws.com/CHAT_MESSAGE/a9d7a5b7-26d2-4ad1-bc8e-39723ef2042f_sample.pdf"
    
    var body: some View {
        
        ZStack{
            VStack(spacing : 0){
                Text("Enter your file URL here.")
                
                TextField("Type here ...", text: $fileUrlString)
                    .frame(minHeight : 100)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(10)
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 8)
                
                if fileDownloadModel.showProgress{
                    ProgressView()
                        .padding()
                }
                
                Button("DOWNLOAD") {
                    if !fileUrlString.isEmpty{
                        fileDownloadModel.startDownload(urlString: fileUrlString)
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth : .infinity)
            }
        }
        .padding()
        .alert(isPresented: $fileDownloadModel.showAlert) {
            Alert(title   : Text("Message"),
                  message : Text(fileDownloadModel.alertMessage),
                  dismissButton : .destructive(Text("OK"), action: {
                
            }))
        }
    }
}

struct FileDownloadDemo_Previews: PreviewProvider {
    static var previews: some View {
        FileDownloadDemo()
    }
}
