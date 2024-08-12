//
//  RightClickView.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 31/07/24.
//


import SwiftUI

#if os(macOS)
struct RightClickView: NSViewRepresentable {
    var onRightClick: () -> Void

    class Coordinator: NSObject {
        var onRightClick: () -> Void

        init(onRightClick: @escaping () -> Void) {
            self.onRightClick = onRightClick
        }

        @objc func rightClicked(_ sender: Any?) {
            onRightClick()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(onRightClick: onRightClick)
    }

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let rightClickGesture = NSClickGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.rightClicked(_:)))
        rightClickGesture.buttonMask = 0x2
        view.addGestureRecognizer(rightClickGesture)
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
#endif
