//
//  APIToken.swift
//  
//
//  Created by Немања Аврамовић on 13.2.24..
//

import Foundation

/// Used by the Authentication Client to receive and store the Token data.
public protocol AuthenticationTokenProtocol: Decodable {
    var isValid: Bool { get }
    var value: String { get }
}
