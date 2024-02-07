//
//  NMAuthenticationView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI

struct NMAuthenticationView: View {
    @EnvironmentObject var viewModel: NMAuthenticationViewModel
    @Binding var isAuthenticated: Bool
    @State var username: String = ""
    @State var password: String = ""
    @State var shouldExpand: Bool = false
    
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
                } loader: { progress in
                    ProgressView()
                } error: { error in
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 17.3)
                        Text(error.description)
                            .padding()
                    }
                    .foregroundColor(NMPalette.error.color)
                    Button("Cancel", action: deauthenticate)
                        .buttonStyle(.borderedProminent)
                } content: { user in
                    Text(user.username)
                        .padding()
                    Button("Logout", action: deauthenticate)
                        .buttonStyle(.borderedProminent)
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
        }
    }
    
    func authenticate() {
        viewModel.login(with: username, and: password)
    }
    
    func deauthenticate() {
        viewModel.logout()
        isAuthenticated = false
    }
}
