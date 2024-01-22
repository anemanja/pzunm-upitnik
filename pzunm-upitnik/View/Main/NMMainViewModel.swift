//
//  NMMainViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

final class NMMainViewModel: ObservableObject {
    @Published var clients: [NMClient] = []
    @Published var user: NMUser?
    @Published var progress = ProgressTracker()
    
    private var authenticationService: NMAuthenticationService
    private var clientsService: NMClientsService
    
    init(authenticationService: NMAuthenticationService, clientsService: NMClientsService) {
        self.authenticationService = authenticationService
        self.clientsService = clientsService
    }
    
    func login(with username: String, and password: String) {
        Task {
            progress.start()
            let result = await authenticationService.authenticateUser(with: username, and: password)
            await MainActor.run {
                switch result {
                case .success:
                    self.user = NMUser(username: username)
                    self.progress.reset()
                case .failure(let error):
                    self.user = nil
                    self.progress.failed(with: error)
                }
            }
        }
    }
    
    func logout() {
        self.user = nil
    }
    
    func refreshClients() {
        progress.start()
        Task {
            let result = await clientsService.getClients(for: user)
            await MainActor.run {
                switch result {
                case .success(let clients):
                    self.clients = clients
                    self.progress.reset()
                case .failure(let error):
                    self.clients = []
                    self.progress.failed(with: error)
                }
            }
        }
    }
}
