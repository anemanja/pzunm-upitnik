//
//  NMClientsViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 30.1.24..
//

import Foundation

final class NMClientsViewModel: LoadingObject {
    @Published private(set) var state = LoadingState<[NMClient]>.idle
    private var clientsService: NMClientsService
    
    init(clientsService: NMClientsService) {
        self.clientsService = clientsService
    }
    
    func load(user: NMUser?) {
        Task {
            state = .loading(0.0)
            let result = await clientsService.getClients(for: user)
            await MainActor.run {
                switch result {
                case .success(let clients):
                    state = .loaded(clients)
                case .failure(let error):
                    state = .failed(error)
                }
            }
        }
    }
    
    func load() {
        load(user: nil)
    }
}
