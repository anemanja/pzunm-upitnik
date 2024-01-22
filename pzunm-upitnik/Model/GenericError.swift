//
//  GenericError.swift
//  Yarnboard
//
//  Created by Nemanja on 3.5.23..
//

import Foundation

public enum GenericError: Error, CustomStringConvertible {
    case customError(message: String)
    case resolveDependency(dependency: String)
    
    public var title: String {
        switch self {
        case .customError(_):
            return "Unknown Error"
        case .resolveDependency(_):
            return "Dependency Injection Error"
        }
    }
    
    public var description: String {
        switch self {
        case .customError(let message):
            return message
        case .resolveDependency(let dependancy):
            return "Failed to resolve dependency: \(dependancy)"
        }
    }
}

public struct ProgressTracker {
    private(set) var currentState: ProgressState = .off
    private(set) var error: GenericError?
    
    enum ProgressState {
        case off
        case on
        case failed
    }
    
    mutating func start() {
        setup(currentState: .on)
    }
    
    mutating func reset() {
        setup(currentState: .off)
    }
    
    mutating func failed(with error: GenericError) {
        setup(currentState: .failed, error: error)
    }
    
    private mutating func setup(currentState: ProgressState, error: GenericError? = nil) {
        self.currentState = currentState
        self.error = error
    }
}
