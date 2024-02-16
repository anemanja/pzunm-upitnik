//
//  ClientsService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol CertificatesServiceProtocol {
    func getCertificates(includingCompleted shouldIncludeCompleted: Bool) async -> Result<[NMCertificate], GenericError>
}

public protocol CertificatesRepositoryProtocol {
    func getCertificates() async -> Result<[NMCertificate], GenericError>
}

public final class CertificatesService: CertificatesServiceProtocol {
    private let repository: CertificatesRepositoryProtocol
    
    public init(repository: CertificatesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getCertificates(includingCompleted shouldIncludeCompleted: Bool = false) async -> Result<[NMCertificate], GenericError> {
        let result = await repository.getCertificates()
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

