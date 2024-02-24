//
//  DataParser.swift
//  
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

public protocol DataParserProtocol {
    func decode<T: Decodable>(_ data: Data) throws -> T
    func encode<T: Encodable>(_ object: T) throws -> Data
}

public enum DataParser: DataParserProtocol {
    case json
    case jsonSnakeCase

    private static let jsonDataParser = JSONDataParser()
    private static let jsonSnakeCaseDataParser = JSONSnakeCaseDataParser()

    public func decode<T: Decodable>(_ data: Data) throws -> T {
        switch self {
        case .json:
            return try DataParser.jsonDataParser.decode(data)
        case .jsonSnakeCase:
            return try DataParser.jsonSnakeCaseDataParser.decode(data)
        }
    }

    public func encode<T>(_ object: T) throws -> Data where T : Encodable {
        switch self {
        case .json:
            return try DataParser.jsonDataParser.encode(object)
        case .jsonSnakeCase:
            return try DataParser.jsonSnakeCaseDataParser.encode(object)
        }
    }
}

class JSONDataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder = JSONDecoder()
    private var jsonEncoder: JSONEncoder = JSONEncoder()

    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }

    func encode<T: Encodable>(_ object: T) throws -> Data {
        return try jsonEncoder.encode(object)
    }
}

class JSONSnakeCaseDataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    private var jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder = JSONDecoder(), jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        self.jsonEncoder = jsonEncoder
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
    }

    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }

    func encode<T: Encodable>(_ object: T) throws -> Data {
        return try jsonEncoder.encode(object)
    }
}
