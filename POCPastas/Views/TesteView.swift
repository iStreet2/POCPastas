//
//  TesteV9ew.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 05/08/24.
//

import SwiftUI

struct DragGestureView: View {
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: "folder.fill")
                .resizable()
                .scaledToFit()
                .frame(width:60)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            withAnimation(.bouncy(duration: 0.2, extraBounce: 0.2)){
                                offset = .zero
                            }
                            
                        }
                )
                .padding(60)
            
        }
    }
    
}

#Preview {
    DragGestureView()
}
