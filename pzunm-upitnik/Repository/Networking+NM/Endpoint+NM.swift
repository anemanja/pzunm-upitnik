//
//  Endpoint+NM.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 14.2.24..
//

import Foundation
import Networking

enum Endpoint: String, APIEndpointProtocol {
    case certificates = "9b82a10d84c4ef60a6d6"

    var path: String {
        self.rawValue
    }
}
