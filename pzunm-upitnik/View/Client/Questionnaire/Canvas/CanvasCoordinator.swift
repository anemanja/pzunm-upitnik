//
//  Coordinator.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import Foundation
import SwiftUI
import PencilKit

class CanvasCoordinator: NSObject {
    var canvasView: Binding<PKCanvasView>
    let onSaved: () -> Void
    let onBegan: () -> Void
    let onEnded: () -> Void
    
    init(canvasView: Binding<PKCanvasView>, onSaved: @escaping () -> Void, onBegan: @escaping () -> Void, onEnded: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onSaved = onSaved
        self.onBegan = onBegan
        self.onEnded = onEnded
    }
}

extension CanvasCoordinator: PKCanvasViewDelegate {
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        onBegan()
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        onEnded()
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        if !canvasView.drawing.bounds.isEmpty {
            onSaved()
        }
    }
}
