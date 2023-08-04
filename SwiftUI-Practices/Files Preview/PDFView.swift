//
//  PDFView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 14/03/2023.
//

import PDFKit
import SwiftUI

struct PDFView: UIViewRepresentable {
    let fileURL: URL
   
    func makeUIView(context: UIViewRepresentableContext<PDFView>) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        DispatchQueue.main.async {
            pdfView.document = PDFDocument(url: fileURL)
        }
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: UIViewRepresentableContext<PDFView>) {
        DispatchQueue.main.async {
            uiView.document = PDFDocument(url: fileURL)
        }
    }
}
