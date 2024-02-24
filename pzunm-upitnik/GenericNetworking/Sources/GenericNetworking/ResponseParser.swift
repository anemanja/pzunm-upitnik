//
//  APIResponseParser.swift
//  
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

/// Implement to parse each **status code** returned from the server.
///
/// Default implementation only checks if the request succeeded with the basic 200 status code.
public protocol ResponseParserProtocol {
    func parse(_ response: URLResponse) throws
}

public class ResponseParser: ResponseParserProtocol {

    public init() {}

    public func parse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
    }
}
