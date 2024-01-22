//
//  AuthenticationService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol NMAuthenticationService {
    func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError>
}

public protocol NMAuthenticationRepository {
    func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError>
}

public final class NMAuthenticationServiceImplementation: NMAuthenticationService {
    private let repository: NMAuthenticationRepository
    
    init(repository: NMAuthenticationRepository) {
        self.repository = repository
    }
    
    public func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError> {
        await repository.authenticateUser(with: username, and: password)
    }
}
