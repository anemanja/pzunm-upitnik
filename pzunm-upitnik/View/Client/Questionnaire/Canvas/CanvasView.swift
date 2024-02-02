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
}

extension CanvasView: UIViewRepresentable {
  func makeUIView(context: Context) -> PKCanvasView {
      canvasView.tool = PKInkingTool(.pen, color: .systemIndigo, width: 10)
    #if targetEnvironment(simulator)
      canvasView.drawingPolicy = .anyInput
    #endif
    return canvasView
  }

  func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}
