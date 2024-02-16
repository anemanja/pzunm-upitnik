//
//  CanvasView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI
import PencilKit

struct CanvasView {
    @Binding var canvasView: PKCanvasView
    let onSaved: () -> Void
    let onBegan: () -> Void
    let onEnded: () -> Void
}

extension CanvasView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .blue, width: 10)
#if targetEnvironment(simulator)
        canvasView.drawingPolicy = .anyInput
#endif
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
    
    func makeCoordinator() -> CanvasCoordinator {
        CanvasCoordinator(canvasView: $canvasView, onSaved: onSaved, onBegan: onBegan, onEnded: onEnded)
    }
}
