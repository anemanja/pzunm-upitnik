//
//  MainView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    
    @State var isAuthenticated = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 100.0)
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200.0)
                Text("UPITNIK O ZDRAVSTVENOM STANJU")
                    .dynamicTypeSize(.xxxLarge)
                Spacer()
                CardView { _ in
                    CertificatesView(viewModel: coordinatorViewModel.dependencyContainer.certificatesViewModel, shouldShowAll: $isAuthenticated)
                }
                .padding()
                Spacer()
            }
            .background(Color.nmBackground)
            VStack {
                AuthenticationView(viewModel: coordinatorViewModel.dependencyContainer.authenticationViewModel, isAuthenticated: $isAuthenticated)
                Spacer()
            }
        }
    }
}
