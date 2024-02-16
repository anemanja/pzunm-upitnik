//
//  CertificationsRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation
import Networking

class CertificatesRepositoryImplementation: CertificatesRepositoryProtocol {
    private let apiClient: APIClient<Endpoint>

    init(apiClient: APIClient<Endpoint>) {
        self.apiClient = apiClient
    }

    func getCertificates() async -> Result<[NMCertificate], GenericError> {
        do {
            let certificates: [NMCertificate] = try await apiClient.read(at: .certificates)
            return .success(certificates)
        } catch let error as NetworkError {
            return .failure(GenericError.networkError(error: error))
        } catch DecodingError.keyNotFound(let codingKey, _) {
            return .failure(GenericError.customError(message: "Failed to decode object at coding key: \(codingKey.stringValue)"))
        } catch let error {
            return .failure(GenericError.customError(message: String(describing: error)))
        }
    }
}
