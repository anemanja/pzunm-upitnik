//
//  AuthenticationService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol AuthenticationServiceProtocol {
    func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError>
}

public final class AuthenticationService: AuthenticationServiceProtocol {
    private let repository: any AuthenticationRepositoryProtocol
    
    public init(repository: any AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
    public func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError> {
        await repository.authenticateUser(with: username, and: password)
    }
}
