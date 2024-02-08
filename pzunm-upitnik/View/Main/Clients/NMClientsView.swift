//
//  NMClientsView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI

struct NMClientsView: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @EnvironmentObject var viewModel: NMClientsViewModel
    @Binding var shouldShowAll: Bool
    
    var body: some View {
        LoadingView(source: viewModel) {
            Button("Učitaj aktivne klijente") {
                viewModel.load(includingCompleted: shouldShowAll)
            }
            .buttonStyle(.borderedProminent)
        } loader: { _ in
            ProgressView()
        } error: { error in
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 50.0)
                Text(error.description)
                    .padding()
            }
            .foregroundColor(NMPalette.error.color)
        } content: { clients in
            List (clients) { client in
                NMClientListItemView(client: client,
                                     shouldShowAll: shouldShowAll)
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinatorViewModel.present(with: client)
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
