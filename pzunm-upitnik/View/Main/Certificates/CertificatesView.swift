//
//  CertificatesView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI

struct CertificatesView: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    @ObservedObject private var viewModel: CertificatesViewModel
    @Binding private var shouldShowAll: Bool

    init(viewModel: CertificatesViewModel, shouldShowAll: Binding<Bool>) {
        self.viewModel = viewModel
        self._shouldShowAll = shouldShowAll
    }
    
    var body: some View {
        LoadingView(source: viewModel) {
            Button("Učitaj aktivna uvjerenja") {
                viewModel.load(includingCompleted: shouldShowAll)
            }
            .buttonStyle(.borderedProminent)
            .accentColor(.nmTitle)
        } loader: { _ in
            NMProgressView()
        } error: { error in
            ErrorView(error) {
                viewModel.load(includingCompleted: shouldShowAll)
            }
        } content: { certificates in
            List (certificates) { certificate in
                CertificateListItemView(certificate: certificate,
                                        shouldShowAll: shouldShowAll)
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinatorViewModel.present(with: certificate)
                }
            }
            .padding()
            .listStyle(.plain)
            .refreshable {
                viewModel.load(includingCompleted: shouldShowAll)
            }
        }
        .onChange(of: shouldShowAll) { newValue in
            viewModel.load(includingCompleted: shouldShowAll)
        }
    }
}
