//
//  SecureStorage.swift
//  
//
//  Created by Немања Аврамовић on 13.2.24..
//

import Foundation

/// Used by Authentication Client to store the token.
///
/// Implementent using Keychain or another type of safe storage on your device.
public protocol SecureStorageProtocol {
    func store(_ value: Any, at key: String)
    func retrieve(at key: String) -> Any
}
