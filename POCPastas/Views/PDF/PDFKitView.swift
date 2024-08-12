//
//  SwiftUIView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 01/08/24.
//
import SwiftUI
import PDFKit

#if os(macOS)
struct PDFKitView: NSViewRepresentable {
    var pdfDocument: PDFDocument
    
    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateNSView(_ nsView: PDFView, context: Context) {
        nsView.document = pdfDocument
    }
}
#endif

#if os(iOS)
struct PDFKitView: UIViewRepresentable {
    var pdfDocument: PDFDocument
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDocument
    }
}
#endif
