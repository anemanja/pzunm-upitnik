//
//  AuthenticationView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject private var viewModel: AuthenticationViewModel
    @Binding private var isAuthenticated: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var shouldExpand: Bool = false

    init(viewModel: AuthenticationViewModel, isAuthenticated: Binding<Bool>) {
        self.viewModel = viewModel
        self._isAuthenticated = isAuthenticated
    }
    
    var body: some View {
        HStack {
            Spacer()
            if shouldExpand {
                LoadingView(source: viewModel) {
                    Spacer()
                    TextInputView("Korisničko ime", text: $username)
                    SecureInputView("Lozinka", text: $password)
                    Button("Login", action: authenticate)
                        .buttonStyle(.borderedProminent)
                        .accentColor(.nmTitle)
                } loader: { progress in
                    NMProgressView()
                } error: { error in
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 17.3)
                        Text(error.description)
                            .padding()
                    }
                    .foregroundColor(.nmError)
                    Button("Cancel", action: deauthenticate)
                        .buttonStyle(.borderedProminent)
                        .accentColor(.nmTitle)
                } content: { user in
                    Text(user.username)
                        .padding()
                    Button("Logout", action: deauthenticate)
                        .buttonStyle(.borderedProminent)
                        .accentColor(.nmTitle)
                        .onAppear {
                            isAuthenticated = true
                        }
                }
            }
            Button {
                withAnimation {
                    shouldExpand.toggle()
                }
            } label: {
                Image(systemName: shouldExpand ? "person.crop.circle.fill" : "person.crop.circle")
                    .padding()
            }
            .accentColor(.nmTitle)
        }
    }
    
    func authenticate() {
        viewModel.login(with: username, and: password)
    }
    
    func deauthenticate() {
        viewModel.logout()
        username = ""
        password = ""
        isAuthenticated = false
    }
}
