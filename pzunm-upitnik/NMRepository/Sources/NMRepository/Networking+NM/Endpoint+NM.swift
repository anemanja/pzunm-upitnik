//
//  Endpoint+NM.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 14.2.24..
//

import Foundation
import GenericNetworking

public enum Endpoint: String, APIEndpointProtocol {
    case certificates = "a507bdd25b6371e98cba"
    case pdf

    public var path: String {
        self.rawValue
    }
}
