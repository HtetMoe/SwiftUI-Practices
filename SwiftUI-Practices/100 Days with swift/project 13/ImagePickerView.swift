//
//  PickedImageView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 20/07/2023.
//

import SwiftUI
import Photos

struct ImagePickerView: View {
    @State private var image: Image?
    @State private var pickedImage : UIImage?
    @State private var showingImagePicker = false
    
    //check photo permission
    @State private var isPhotoAuthorized = false
    
    var body: some View {
        
        VStack{
            if isPhotoAuthorized{
                image?
                    .resizable()
                    .scaledToFit()
                
                //select
                Button("Select Image") {
                    showingImagePicker = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                //save
                Button("Save Image") {
                    guard let inputImage = pickedImage else { return }
                    
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhotoAlbum(image: inputImage)
                }
            }
            else{
                Button("Request Photo Access") {
                    requestPhotoPermission()
                }.buttonStyle(.bordered)
            }
            
        }
        .onAppear(perform: requestPhotoPermission)
        .sheet(isPresented: $showingImagePicker, content: {
            ImagePicker(image: $pickedImage)
        })
        .onChange(of: pickedImage, perform: { _ in
            loadImage()
        })
    }
    
    func loadImage(){
        guard let resultImage = pickedImage else { return }
        image = Image(uiImage: resultImage)
    }
    
    //check photo permission
    func requestPhotoPermission(){
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    isPhotoAuthorized = true
                case .denied, .restricted, .notDetermined:
                    isPhotoAuthorized = false
                default:
                    break
                }
            }
        }
    }
}

struct PickedImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
