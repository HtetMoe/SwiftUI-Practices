//
//  FileDownloadTaskModel.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 20/03/2023.
//

import Foundation
import SwiftUI

class FileDownloadTaskModel : NSObject,
                              ObservableObject,
                              URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate{
    
    @Published var downloadURL : URL!
    
    //file download err alert
    @Published var alertMessage = ""
    @Published var showAlert    = false
    
    //save download task reference for cancelling
    @Published var downloadTaskSession : URLSessionDownloadTask!
    
    //download progress
    @Published var downloadProgress : CGFloat = 0
    @Published var showProgress = false
    
    //download
    func  startDownload(urlString : String?){
        //check validUrl
        guard let validFileURL = URL(string: urlString ?? "") else {
            let error = "Invalid URL!"
            self.reportError(error: error)
            return
        }
        
        //prevent download the sameFile again
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if FileManager.default.fileExists(atPath: directoryPath.appendingPathComponent(validFileURL.lastPathComponent).path){
            print("yes file found.")
            let controller = UIDocumentInteractionController(url: directoryPath.appendingPathComponent(validFileURL.lastPathComponent))
            
            controller.delegate = self
            controller.presentPreview(animated: true)
        }
        else{
            print("no file found.")
            
            self.downloadProgress = 0
            withAnimation { self.showProgress = true }
            
            //downloadTask
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            downloadTaskSession = session.downloadTask(with: validFileURL)
            downloadTaskSession.resume()
        }
        
    }
    
    func reportError(error : String){
        DispatchQueue.main.async {
            self.alertMessage = error
            self.showAlert.toggle()
        }
    }
    
    //MARK: URL session functions
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)   {
        /*
         actually it will download as temporary data, so you have to save it
         in app's document directory and show it in document controller
         */
        
        guard let fileURL = downloadTask.originalRequest?.url else{
            DispatchQueue.main.async {
                self.reportError(error: "Sth went wrong!")
            }
            return
        }
        
        let directoryPath   = FileManager.default.urls(for : .documentDirectory, in  : .userDomainMask)[0]
        let destinationURL = directoryPath.appendingPathComponent(fileURL.lastPathComponent)
        
        //if already file there, remove it first
        try? FileManager.default.removeItem(at: destinationURL)
        
        do {
            //copying temp file to directory
            try FileManager.default.moveItem(at: location, to: destinationURL)
            print("File successfully saved at \(destinationURL)")
            
            //if success, close progress
            DispatchQueue.main.async {
                withAnimation { self.showProgress = false}
                
                //presenting the file with help of document interaction controller from UIKit
                let controller = UIDocumentInteractionController(url: destinationURL)
                
                controller.delegate = self
                controller.presentPreview(animated: true)
            }
        } catch {
            let error = "Download failed : \(error.localizedDescription)"
            DispatchQueue.main.async {
                self.reportError(error: "Download Failed! Try Again.")
            }
        }
    }
    
    //get progress
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        print("downloading : \(progress)")
         
        //running url session in bg Thread, but UI update in mainThread
        DispatchQueue.main.async { self.downloadProgress = progress }
    }
    
    //error
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            withAnimation{self.showProgress = false}
            if let error = error{
                self.reportError(error: error.localizedDescription)
                return
            }
        }
    }
    
    //you can use this for download task cancel
    func cancelTask(){
        if let task = downloadTaskSession, task.state == .running {
            downloadTaskSession.cancel()
            withAnimation{self.showProgress = false}
        }
    }
    
    //sub func for presentationView
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return (UIApplication.shared.connectedScenes.map({$0 as! UIWindowScene}).compactMap({$0}).first?.windows.first?.rootViewController!)!
    }
    
}
