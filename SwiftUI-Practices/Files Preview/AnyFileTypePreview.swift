//
//  AnyFileTypePreview.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/03/2023.
//

import SwiftUI

struct AnyFileTypePreview: View {
    @Binding var url : URL?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack{
                if let fileUrl = url {
                    let fileType = fileUrl.pathExtension
                   
                    if fileType == "pdf"{
                        PDFView(fileURL: fileUrl)
                    }
                    else{
                        WebView(url: fileUrl)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement : .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .medium))
                    })
                }
            }
        }
    }
}

struct AnyFileTypePreview_Previews: PreviewProvider {
    static var previews: some View {
        AnyFileTypePreview(url: .constant(nil))
    }
}
