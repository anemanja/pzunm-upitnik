//
//  NMAuthenticationView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import SwiftUI

struct NMAuthenticationView: View {
    var viewModel: NMAuthenticationViewModel
    @Binding var isAuthenticated: Bool
    @State var username: String
    @State var password: String
    
    var body: some View {
        VStack {
            LoadingView(source: viewModel) {
                VStack {
                    TextInputView("Korisničko ime", text: $username)
                    SecureInputView("Lozinka", text: $password)
                }
            } loader: { progress in
                ProgressView()
            } error: { error, _ in
                Text(error.localizedDescription)
            } content: { user in
                Text("\(user.username)")
            }
            Spacer()
            Button(action: authenticate) {
                Image(systemName: "person.crop.circle")
            }
        }
    }
    
    func authenticate() {
        viewModel.login(with: username, and: password)
    }
}
