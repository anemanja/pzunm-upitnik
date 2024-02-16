//
//  PDFService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol PDFServiceProtocol {
    func uploadPDF(at path: URL, for certificateId: String) async -> Result<Void, GenericError>
}

public protocol PDFRepositoryProtocol {
    func uploadPDF(at path: URL, for certificateId: String) async -> Result<Void, GenericError>
}

public final class NMPDFServiceImplementation: PDFServiceProtocol {
    private var repository: PDFRepositoryProtocol
    
    init(repository: PDFRepositoryProtocol) {
        self.repository = repository
    }
    
    public func uploadPDF(at path: URL, for certificateId: String) async -> Result<Void, GenericError> {
        await repository.uploadPDF(at: path, for: certificateId)
    }
}
