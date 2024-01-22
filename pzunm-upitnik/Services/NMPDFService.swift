//
//  PDFService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol NMPDFService {
    func uploadPDF(at path: URL, for clientId: String) async -> Result<Void, GenericError>
}

public protocol NMPDFRepository {
    func uploadPDF(at path: URL, for clientId: String) async -> Result<Void, GenericError>
}

public final class NMPDFServiceImplementation: NMPDFService {
    private var repository: NMPDFRepository
    
    init(repository: NMPDFRepository) {
        self.repository = repository
    }
    
    public func uploadPDF(at path: URL, for clientId: String) async -> Result<Void, GenericError> {
        await repository.uploadPDF(at: path, for: clientId)
    }
}
