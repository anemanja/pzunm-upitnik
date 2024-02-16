//
//  AuthenticationViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

final class AuthenticationViewModel: LoadingObject {
    @Published private(set) var state = LoadingState<NMUser>.idle

    private var authenticationService: any AuthenticationServiceProtocol
    
    init(authenticationService: any AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }

    func login(with username: String, and password: String) {
        Task {
            await MainActor.run {
                state = .loading(0.0)
            }
            let result = await authenticationService.authenticateUser(with: username, and: password)
            await MainActor.run {
                switch result {
                case .success:
                    state = .loaded(NMUser(username: username))
                case .failure(let error):
                    state = .failed(error)
                }
            }
        }
    }
    
    func logout() {
        state = .idle
    }
}
