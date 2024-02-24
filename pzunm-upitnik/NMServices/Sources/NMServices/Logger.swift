//
//  Logger.swift
//  Yarnboard
//
//  Created by Nemanja on 22.5.23..
//

import Foundation

public protocol Logger {
    func debug(_ message: String?, tag: String)
    func info(_ message: String?, tag: String)
    func warning(_ message: String?, tag: String)
    func error(_ message: String?, tag: String)
    func genericError(_ error: GenericError, tag: String)
}

public class ConsoleLogger: Logger {
    public init() {}
    
    public func debug(_ message: String?, tag: String) {
        insertLog("DEBUG", message: message, tag: tag)
    }
    
    public func info(_ message: String?, tag: String) {
        insertLog("INFO", message: message, tag: tag)
    }
    
    public func warning(_ message: String?, tag: String) {
        insertLog("WARNING", message: message, tag: tag)
    }
    
    public func error(_ message: String?, tag: String) {
        insertLog("ERROR", message: message, tag: tag)
    }
    
    public func genericError(_ error: GenericError, tag: String) {
        insertLog(error.title, message: error.description, tag: tag)
    }
    
    public func insertLog(_ prefix: String, message: String?, tag: String) {
        if let message = message {
            print(prefix + ": " + message + "\n" + tag)
        } else {
            print(prefix + "\n" + tag)
        }
    }
}
