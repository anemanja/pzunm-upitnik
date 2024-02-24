//
//  RequestBuilder.swift
//  
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

/// Used by API and Authentication Clients to build URLRequests for API calls.
///
/// Implement to define your default request values like scheme, host, data type, etc.
/// Use different Request Builder Implementations for different configurations.
public protocol RequestBuilderProtocol {

    /// Resets all values and starts building the Request from zero.
    @discardableResult
    func initiate() throws -> Self

    /// Request modifiers.
    @discardableResult
    func setEndpoint(_ endpoint: String) throws -> Self

    @discardableResult
    func setHeaders(_ headers: [String: String]) throws -> Self

    @discardableResult
    func setParameters(_ parameters: [String: String?]) throws -> Self

    @discardableResult
    func setMethod(_ method: RequestMethod) throws -> Self

    @discardableResult
    func setData(_ data: Data) throws -> Self

    @discardableResult
    func setMultipartData(_ data: Data, named name: String) throws -> Self

    @discardableResult
    func setAuthentication(_ token: String) throws -> Self

    /// Builds the URL request.
    @discardableResult
    func buildURLRequest() throws -> URLRequest
}
