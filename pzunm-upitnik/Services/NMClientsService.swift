//
//  ClientsService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol NMClientsService {
    func getClients(includingCompleted shouldIncludeCompleted: Bool) async -> Result<[NMClient], GenericError>
}

public protocol NMClientsRepository {
    func getClients() async -> Result<[NMClient], GenericError>
}

public final class NMClientsServiceImplementation: NMClientsService {
    private let repository: NMClientsRepository
    
    init(repository: NMClientsRepository) {
        self.repository = repository
    }
    
    public func getClients(includingCompleted shouldIncludeCompleted: Bool = false) async -> Result<[NMClient], GenericError> {
        let result = await repository.getClients()
        switch result {
        case .success(let clients):
            if !shouldIncludeCompleted {
                return .success(clients.filter{ !$0.hasCompletedQuestionnaire })
            } else {
                return .success(clients)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

