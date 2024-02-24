//
//  AuthenticationRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.2.24..
//

import Foundation

public protocol AuthenticationRepositoryProtocol {
    func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError>
}
