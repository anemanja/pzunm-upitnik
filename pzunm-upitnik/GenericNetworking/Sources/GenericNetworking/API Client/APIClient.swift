//
//  APIClient.swift
//  
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

/// API Client Protocol covers the basic CRUD operations both with authentication and without it.
public protocol APIClientProtocol {
    associatedtype Endpoint: APIEndpointProtocol

    func create<T: Encodable>(_ object: T, at endpoint: Endpoint) async throws
    func createAuthenticated<T: Encodable>(_ object: T, at endpoint: Endpoint) async throws
    func read<T: Decodable>(respecting parameters: [String: String]?, at endpoint: Endpoint) async throws -> T
    func readAuthenticated<T: Decodable>(respecting parameters: [String: String]?, at endpoint: Endpoint) async throws -> T
    func update<T: Encodable>(_ object: T, respecting parameters: [String: String], at endpoint: Endpoint) async throws
    func updateAuthenticated<T: Encodable>(_ object: T, respecting parameters: [String: String], at endpoint: Endpoint) async throws
    func delete(respecting parameters: [String: String], at endpoint: Endpoint) async throws
    func deleteAuthenticated(respecting parameters: [String: String], at endpoint: Endpoint) async throws

    func upload(file data: Data, named name: String, to endpoint: Endpoint) async throws
    func uploadAuthenticated(file data: Data, named name: String, to endpoint: Endpoint) async throws
}

/// Out of the box API Client implementation that uses exactly one Data Parser, Request Builder and Authentication Client.
public class APIClient<Endpoint: APIEndpointProtocol>: APIClientProtocol {
    private let urlSession: URLSession
    private let dataParser: any DataParserProtocol
    private let responseParser: any ResponseParserProtocol
    private let requestBuilder: any RequestBuilderProtocol
    private let authenticationClient: (any AuthenticationClientProtocol)?

    public init(urlSession: URLSession = URLSession.shared, dataParser: any DataParserProtocol, responseParser: any ResponseParserProtocol, requestBuilder: any RequestBuilderProtocol, authenticationClient: (any AuthenticationClientProtocol)? = nil) {
        self.urlSession = urlSession
        self.dataParser = dataParser
        self.responseParser = responseParser
        self.requestBuilder = requestBuilder
        self.authenticationClient = authenticationClient
    }

    private func performAuthenticationRequest() async throws {
        guard let authenticationClient = authenticationClient else {
            throw NetworkError.missingAuthenticationClient
        }
        try await requestBuilder.setAuthentication(authenticationClient.retrieveToken())
    }

    @discardableResult
    private func performRequest(withAuthentication shouldAuthenticate: Bool) async throws -> Data {
        if shouldAuthenticate {
            try await performAuthenticationRequest()
        }
        let (data, response) = try await urlSession.data(for: requestBuilder.buildURLRequest())
        try responseParser.parse(response)
        return data
    }

    private func create<T: Encodable>(_ object: T, at endpoint: Endpoint, shouldAuthenticate: Bool) async throws {
        try requestBuilder
            .initiate()
            .setMethod(.POST)
            .setEndpoint(endpoint.path)
            .setData(dataParser.encode(object))

        try await performRequest(withAuthentication: shouldAuthenticate)
    }

    private func read<T: Decodable>(respecting parameters: [String: String]? = nil, at endpoint: Endpoint, shouldAuthenticate: Bool) async throws -> T {
        try requestBuilder
            .initiate()
            .setMethod(.GET)
            .setEndpoint(endpoint.path)

        if let parameters = parameters {
            try requestBuilder.setParameters(parameters)
        }

        let data = try await performRequest(withAuthentication: shouldAuthenticate)
        return try dataParser.decode(data)
    }

    private func update<T: Encodable>(_ object: T, respecting parameters: [String: String], at endpoint: Endpoint, shouldAuthenticate: Bool) async throws {
        try requestBuilder
            .initiate()
            .setMethod(.PUT)
            .setEndpoint(endpoint.path)
            .setParameters(parameters)
            .setData(dataParser.encode(object))

        try await performRequest(withAuthentication: shouldAuthenticate)
    }

    private func delete(respecting parameters: [String: String], at endpoint: Endpoint, shouldAuthenticate: Bool) async throws {
        try requestBuilder
            .initiate()
            .setMethod(.POST)
            .setEndpoint(endpoint.path)
            .setParameters(parameters)

        try await performRequest(withAuthentication: shouldAuthenticate)
    }

    private func upload(file data: Data, named name: String, to endpoint: Endpoint, shouldAuthenticate: Bool) async throws {
        try requestBuilder
            .initiate()
            .setMethod(.POST)
            .setEndpoint(endpoint.path)
            .setMultipartData(data, named: name)

        try await performRequest(withAuthentication: shouldAuthenticate)
    }

}

extension APIClient {
    public func create<T>(_ object: T, at endpoint: Endpoint) async throws where T : Encodable {
        try await create(object, at: endpoint, shouldAuthenticate: false)
    }

    public func createAuthenticated<T>(_ object: T, at endpoint: Endpoint) async throws where T : Encodable {
        try await create(object, at: endpoint, shouldAuthenticate: true)
    }

    public func read<T>(respecting parameters: [String : String]? = nil, at endpoint: Endpoint) async throws -> T where T : Decodable {
        try await read(respecting: parameters, at: endpoint, shouldAuthenticate: false)
    }

    public func readAuthenticated<T>(respecting parameters: [String : String]? = nil, at endpoint: Endpoint) async throws -> T where T : Decodable {
        try await read(respecting: parameters, at: endpoint, shouldAuthenticate: true)
    }

    public func update<T>(_ object: T, respecting parameters: [String : String], at endpoint: Endpoint) async throws where T : Encodable {
        try await update(object, respecting: parameters, at: endpoint, shouldAuthenticate: false)
    }

    public func updateAuthenticated<T>(_ object: T, respecting parameters: [String : String], at endpoint: Endpoint) async throws where T : Encodable {
        try await update(object, respecting: parameters, at: endpoint, shouldAuthenticate: true)
    }

    public func delete(respecting parameters: [String : String], at endpoint: Endpoint) async throws {
        try await delete(respecting: parameters, at: endpoint, shouldAuthenticate: false)
    }

    public func deleteAuthenticated(respecting parameters: [String : String], at endpoint: Endpoint) async throws {
        try await delete(respecting: parameters, at: endpoint, shouldAuthenticate: true)
    }

    public func upload(file data: Data, named name: String, to endpoint: Endpoint) async throws {
        try await upload(file: data, named: name, to: endpoint, shouldAuthenticate: false)
    }

    public func uploadAuthenticated(file data: Data, named name: String, to endpoint: Endpoint) async throws {
        try await upload(file: data, named: name, to: endpoint, shouldAuthenticate: true)
    }
}
