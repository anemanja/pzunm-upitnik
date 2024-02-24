//
//  MainView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct MainView<Certificates: View, Authentication: View>: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    @State private var isAuthenticated = false

    private var certificatesView: (Binding<Bool>) -> Certificates
    private var authenticationView: (Binding<Bool>) -> Authentication

    init(@ViewBuilder certificatesView: @escaping (Binding<Bool>) -> Certificates,
         @ViewBuilder authenticationView: @escaping (Binding<Bool>) -> Authentication) {
        self.certificatesView = certificatesView
        self.authenticationView = authenticationView
    }

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
                    certificatesView($isAuthenticated)
                }
                .padding()
                Spacer()
            }
            .background(Color.nmBackground)
            VStack {
                authenticationView($isAuthenticated)
                Spacer()
            }
        }
    }
}
