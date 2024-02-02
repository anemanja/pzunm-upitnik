//
//  LoadingView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI

struct LoadingView<Source: LoadingObject, LoaderView: View, ErrorView: View, ContentView: View>: View {
    @ObservedObject var source: Source
    var loader: (CGFloat) -> LoaderView
    var error: (Error, () -> Void) -> ErrorView
    var content: (Source.Output) -> ContentView
    
    init(source: Source,
         @ViewBuilder loader: @escaping (CGFloat) -> LoaderView,
         @ViewBuilder error: @escaping (Error, () -> Void) -> ErrorView,
         @ViewBuilder content: @escaping (Source.Output) -> ContentView) {
        self.source = source
        self.loader = loader
        self.error = error
        self.content = content
    }
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading(let progress):
            self.loader(progress)
        case .failed(let error):
            self.error(error, source.load)
        case .loaded(let output):
            self.content(output)
        }
    }
}
