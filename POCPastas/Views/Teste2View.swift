//
//  Teste2View.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 05/08/24.
//

import SwiftUI

struct Teste2View: View {
    @State private var positions: [CGPoint] = []
    
    let items = Array(0..<50)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Text("Item \(item)")
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .capturePosition()
                }
            }
        }
        .onPreferenceChange(ViewPositionKey.self) { positions in
            self.positions = positions
            print(positions) // Exibe as posições no console para debug
        }
        .frame(width: 500)
        .padding()
    }
}


#Preview {
    Teste2View()
}

struct ViewPositionKey: PreferenceKey {
    typealias Value = [CGPoint]
    
    static var defaultValue: [CGPoint] = []
    
    static func reduce(value: inout [CGPoint], nextValue: () -> [CGPoint]) {
        value.append(contentsOf: nextValue())
    }
}

struct CaptureViewPosition: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear
                .preference(key: ViewPositionKey.self, value: [geometry.frame(in: .global).origin])
        })
    }
}

extension View {
    func capturePosition() -> some View {
        self.modifier(CaptureViewPosition())
    }
}
