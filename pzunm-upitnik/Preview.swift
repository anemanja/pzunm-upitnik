//
//  Preview.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.1.24..
//

import SwiftUI

struct Preview: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @State var shouldShowAll: Bool
    @State var loadingState = LoadingState<[NMClient]>.idle
    @State var shouldFail = false
    
    var body: some View {
        VStack {
            Spacer()
            switch loadingState {
            case .idle:
                Button("Učitaj aktivne klijente") {
                    load()
                }
                .buttonStyle(.borderedProminent)
            case .loading(_):
                ProgressView()
            case .failed(let error):
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 50.0)
                    Text(error.description)
                        .padding()
                }
                .foregroundColor(NMPalette.error.color)
            case .loaded(let clients):
                List (clients) { client in
                    NMClientListItemView(client: client,
                                         shouldShowAll: shouldShowAll)
                    .onTapGesture {
                        coordinatorViewModel.present(with: client)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    load()
                }
            }
            Spacer()
            HStack {
                Toggle("Should Fail:", isOn: $shouldFail)
                    .frame(maxWidth: 200.0)
                Button("Finish", action: loaded)
                    .padding()
                    .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
    }
    
    func load() {
        loadingState = .loading(0.0)
    }
    
    func loaded() {
        if shouldFail {
            loadingState = .failed(GenericError.customError(message: "Greška."))
        } else {
            loadingState = .loaded([
                NMClient(id: "0012301", name: "Murat", surname: "Osmanoglu",
                         language: .tur, hasCompletedQuestionnaire: false),
                NMClient(id: "0233540", name: "Berat", surname: "Krasnichi",
                         language: .alb, hasCompletedQuestionnaire: true),
                NMClient(id: "0003153", name: "Radovan", surname: "Berović",
                         language: .srb, hasCompletedQuestionnaire: false),
                NMClient(id: "1125003", name: "Osman", surname: "Jagluk",
                         language: .tur, hasCompletedQuestionnaire: true),
                NMClient(id: "0002318", name: "Vukomir", surname: "Avramović",
                         language: .srb, hasCompletedQuestionnaire: false)
            ])
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(shouldShowAll: true)
            .environmentObject(CoordinatorViewModel())
    }
}
