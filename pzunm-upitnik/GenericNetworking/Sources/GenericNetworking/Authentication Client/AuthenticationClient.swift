//
//  File.swift
//  
//
//  Created by Немања Аврамовић on 13.2.24..
//

import Foundation

/// Used by API Client to authenticate its API calls.
public protocol AuthenticationClientProtocol {
    func retrieveToken() async throws -> String
}

/// Out of the box AuthenticationClient.
///
/// Implement an Authentication Request Builder to be used by AuthenticationClient. Data Parser and API Response Parser may be the same as API Client's.
public class AuthenticationClient<Token: AuthenticationTokenProtocol> {
    private let urlSession: URLSession
    private let requestBuilder: RequestBuilderProtocol
    private let secureStorage: any SecureStorageProtocol
    private let dataParser: any DataParserProtocol
    private let apiResponseParser: any ResponseParserProtocol

    public init(urlSession: URLSession = URLSession.shared, requestBuilder: RequestBuilderProtocol, secureStorage: any SecureStorageProtocol, dataParser: any DataParserProtocol, apiResponseParser: any ResponseParserProtocol) {
        self.urlSession = urlSession
        self.requestBuilder = requestBuilder
        self.secureStorage = secureStorage
        self.dataParser = dataParser
        self.apiResponseParser = apiResponseParser
    }

    public func retrieveToken() async throws -> String {
        guard let oldToken: Token = secureStorage.retrieve(at: "\(Token.self)") as? Token,
              oldToken.isValid
        else {
            try requestBuilder
                .initiate()
                .buildURLRequest()
            let (data, response) = try await urlSession.data(for: requestBuilder.buildURLRequest())
            try apiResponseParser.parse(response)
            let token: Token = try dataParser.decode(data)
            let tokenValue = token.value
            secureStorage.store(tokenValue, at: "\(Token.self)")
            return tokenValue
        }

        return oldToken.value
    }
}
