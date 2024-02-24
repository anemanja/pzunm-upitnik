//
//  PDFRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 23.2.24..
//

import Foundation
import Networking

class PDFRepository: PDFRepositoryProtocol {
    private let apiClient: APIClient<Endpoint>

    init(apiClient: APIClient<Endpoint>) {
        self.apiClient = apiClient
    }

    func uploadPDF(at path: URL, for certificateId: String) async -> Result<Void, GenericError> {
        do {
            let data = try Data(contentsOf: path)
            try await apiClient.upload(file: data, named: "\(certificateId).pdf", to: .pdf)
            return .success(())
        } catch let error {
            return .failure(.customError(message: "\(String(describing: error))"))
        }
    }
}
