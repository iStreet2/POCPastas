//
//  Teste2View.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 05/08/24.
//

import SwiftUI

struct Teste2View: View {
    @State private var positions: [String: CGPoint] = [:]
    @State var andre: CGPoint = CGPoint(x: 123, y: 123)
    
    let items = Array(0..<50).map { "Item \($0)" } // Agora os itens são Strings
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .capturePosition(id: item) // Aplicando o modificador com ID String
                }
            }
        }
        .onPreferenceChange(ViewPositionKey.self) { positions in
            self.positions = positions
            print(positions) // Exibe as posições no console para debug
        }
        .frame(width:500)
    }
}



#Preview {
    Teste2View()
}

struct ViewPositionKey: PreferenceKey {
    typealias Value = [String: CGPoint]
    
    static var defaultValue: [String: CGPoint] = [:]
    
    static func reduce(value: inout [String: CGPoint], nextValue: () -> [String: CGPoint]) {
        value.merge(nextValue()) { (current, new) in new }
    }
}



struct CaptureViewPosition: ViewModifier {
    var id: String
    
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear
                .preference(key: ViewPositionKey.self, value: [id: geometry.frame(in: .global).origin])
        })
    }
}

extension View {
    func capturePosition(id: String) -> some View {
        self.modifier(CaptureViewPosition(id: id))
    }
}
