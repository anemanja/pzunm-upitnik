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
    
    init(canvasView: Binding<PKCanvasView>, onSaved: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onSaved = onSaved
    }
}

extension CanvasCoordinator: PKCanvasViewDelegate {    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        if !canvasView.drawing.bounds.isEmpty {
            onSaved()
        }
    }
}
