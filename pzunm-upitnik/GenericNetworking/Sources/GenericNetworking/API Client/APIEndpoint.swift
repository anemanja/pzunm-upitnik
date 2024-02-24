//
//  APIEndpoint.swift
//  
//
//  Created by Немања Аврамовић on 13.2.24..
//

import Foundation

/// Use this protocol to collect your endpoints.
///
/// Create the APIEndpoint enum that will contain each endpoint as a case.
/// Implement the path variable as follows:
/// ```
/// enum APIEndpoint: String, APIEndpointProtocol {
///     case endpoint1
///     case endpoint2
///
///     var path: String {
///         self.rawValue
///     }
/// }
/// ```
public protocol APIEndpointProtocol {
    var path: String { get }
}
