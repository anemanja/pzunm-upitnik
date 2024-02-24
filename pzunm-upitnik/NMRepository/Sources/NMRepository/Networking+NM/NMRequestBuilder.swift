//
//  NMRequestBuilder.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 14.2.24..
//

import Foundation
import GenericNetworking

public class NMRequestBuilder: RequestBuilderProtocol {
    private var request: URLRequest?

    @discardableResult
    public func initiate() throws -> Self {
        var components = URLComponents()
        components.scheme = APIConfiguration.scheme.rawValue
        components.port = Int(APIConfiguration.port.rawValue)
        components.host = APIConfiguration.host.rawValue
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        request = URLRequest(url: url)
        return self
    }

    @discardableResult
    public func setEndpoint(_ endpoint: String) throws -> Self {
        guard request != nil, request?.url != nil else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        request?.url?.append(path: endpoint)
        return self
    }

    @discardableResult
    public func setHeaders(_ headers: [String : String]) throws -> Self {
        guard request != nil, request?.url != nil else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        for (key, value) in headers {
            request?.addValue(value, forHTTPHeaderField: key)
        }
        return self
    }

    @discardableResult
    public func setParameters(_ parameters: [String : String?]) throws -> Self {
        guard request != nil, request?.url != nil else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        request?.url?.append(queryItems: parameters.map{ URLQueryItem(name: $0, value: $1) })
        return self
    }

    @discardableResult
    public func setMethod(_ method: RequestMethod) throws -> Self {
        guard request != nil, request?.url != nil else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        request?.httpMethod = method.rawValue
        return self
    }

    @discardableResult
    public func setData(_ data: Data) throws -> Self {
        guard request != nil, request?.url != nil else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request?.httpBody?.append(data)
        return self
    }

    @discardableResult
    public func setAuthentication(_ token: String) throws -> Self {
        guard request != nil, request?.url != nil else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        request?.addValue(token, forHTTPHeaderField: "Authentication")
        return self
    }

    @discardableResult
    public func setMultipartData(_ data: Data, named name: String) throws -> Self {
        throw NetworkError.unableToEncodeFileData
    }

    @discardableResult
    public func buildURLRequest() throws -> URLRequest {
        guard let returnRequest = request else {
            throw NetworkError.uninitiatedRequestBuilder
        }
        try initiate()
        return returnRequest
    }
}
