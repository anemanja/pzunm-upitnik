//
//  AuthenticationRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 24.2.24..
//

import Foundation
import NMServices

public final class AuthenticationRepository: AuthenticationRepositoryProtocol {
    public init() {}

    public func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError> {
        
        if username == "admin" && password == "admin" {
            return .success(())
        }

        return .failure(GenericError.customError(message: "Wrong Credentials."))
    }
}
