//
//  NetworkError.swift
//  
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

public enum NetworkError: String, Error {
    case invalidURL = "Invalid URL."
    case invalidServerResponse = "Invalid Server Response."
    case missingAuthenticationClient = "No Authentication Client was provided to the API Client."
    case uninitiatedRequestBuilder = "Requested Builder was not initiated."
    case unableToEncodeFileData = "Encoding file data to utf8 failed while building a multipart/form request."
}
