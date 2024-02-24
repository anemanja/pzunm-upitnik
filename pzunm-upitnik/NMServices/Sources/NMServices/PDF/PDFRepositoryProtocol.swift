//
//  PDFRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.2.24..
//

import Foundation

public protocol PDFRepositoryProtocol {
    func uploadPDF(at path: URL, for certificateId: String) async -> Result<Void, GenericError>
}
