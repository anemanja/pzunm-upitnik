//
//  LoadingView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI
import NMServices

struct LoadingView<Source: LoadingObject, InitialView: View, LoaderView: View, ErrorView: View, ContentView: View>: View {
    @ObservedObject private var source: Source
    private var initial: () -> InitialView
    private var loader: (CGFloat) -> LoaderView
    private var error: (GenericError) -> ErrorView
    private var content: (Source.Output) -> ContentView
    
    init(source: Source,
         @ViewBuilder initial: @escaping () -> InitialView,
         @ViewBuilder loader: @escaping (CGFloat) -> LoaderView,
         @ViewBuilder error: @escaping (GenericError) -> ErrorView,
         @ViewBuilder content: @escaping (Source.Output) -> ContentView) {
        self.source = source
        self.initial = initial
        self.loader = loader
        self.error = error
        self.content = content
    }
    
    var body: some View {
        switch source.state {
        case .idle:
            self.initial()
        case .loading(let progress):
            self.loader(progress)
        case .failed(let error):
            self.error(error)
        case .loaded(let output):
            self.content(output)
        }
    }
}
