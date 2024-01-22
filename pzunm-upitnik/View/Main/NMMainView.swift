//
//  NMMainView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct NMMainView: View {
    @EnvironmentObject private var viewModel: NMMainViewModel
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
            }
            Image("logo")
            Text("UPITNIK O ZDRAVSTVENOM STANJU")
            List (viewModel.clients) { client in
                NMClientListItem(client: client,
                                 shouldShowAll: viewModel.user != nil)
                    .onTapGesture {
                        coordinatorViewModel.present(with: client)
                    }
            }
        }
        .padding()
        .onAppear {
            viewModel.refreshClients()
        }
    }
}

struct NMClientListItem: View {
    @State var client: NMClient
    @State var shouldShowAll: Bool
    
    var body: some View {
        ZStack {
            if shouldShowAll {
                Color(client.hasCompletedQuestionnaire ? .init(red: 0.9, green: 1.0, blue: 0.7, alpha: 1.0) : .clear)
                    .frame(minWidth: 50.0, alignment: .center)
            }
            HStack(alignment: .center) {
                Text(client.id)
                    .foregroundColor(.red)
                    .frame(minWidth: 100.0, alignment: .trailing)
                Text(client.surname)
                Text(client.name)
                Spacer()
                if shouldShowAll {
                    Text(client.hasCompletedQuestionnaire ? "✅" : "⏳")
                        .frame(minWidth: 50.0, alignment: .center)
                }
            }
        }
    }
}

struct NMMainView_Previews: PreviewProvider {
    static var previews: some View {
        NMMainView()
            .environmentObject(NMMainViewModel(
                authenticationService: NMAuthenticationServiceImplementation(repository: MockRepositoryModule().authentication),
                clientsService: NMClientsServiceImplementation(repository: MockRepositoryModule().clients)))
            .environmentObject(CoordinatorViewModel())
    }
}
