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
    
    func load(includingCompleted shouldIncludeCompleted: Bool = false) {
        Task {
            await MainActor.run {
                state = .loading(0.0)
            }
            
            let result = await clientsService.getClients(includingCompleted: shouldIncludeCompleted)
            await MainActor.run {
                switch result {
                case .success(let clients):
                    state = .loaded(clients.sorted {
                        $0.hasCompletedQuestionnaire && !$1.hasCompletedQuestionnaire
                    })
                case .failure(let error):
                    state = .failed(error)
                }
            }
        }
    }
}
