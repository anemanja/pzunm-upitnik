//
//  File.swift
//  
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

/// An enum containing all of the HTTP methods.
///
/// Used by the RequestBuilderProtocol to build a URLRequest.
public enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    case HEAD
    case CONNECT
    case OPTIONS
    case TRACE
}
