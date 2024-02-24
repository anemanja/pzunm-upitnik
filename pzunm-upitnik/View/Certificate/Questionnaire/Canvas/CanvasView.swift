//
//  CanvasView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI
import PencilKit

struct CanvasView {
    @Binding private var canvasView: PKCanvasView
    private let onSaved: () -> Void

    init(canvasView: Binding<PKCanvasView>, onSaved: @escaping () -> Void) {
        self._canvasView = canvasView
        self.onSaved = onSaved
    }
}

extension CanvasView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .blue, width: 3)
#if targetEnvironment(simulator)
        canvasView.drawingPolicy = .anyInput
#endif
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
    
    func makeCoordinator() -> CanvasCoordinator {
        CanvasCoordinator(canvasView: $canvasView, onSaved: onSaved)
    }
}
