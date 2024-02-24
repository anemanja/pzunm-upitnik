//
//  CertificationsRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation
import GenericNetworking
import NMServices
import NMModel

public class CertificatesRepository: CertificatesRepositoryProtocol {
    private var apiClient: APIClient<Endpoint>

    public init(apiClientWrapper: NMAPIClientWrapper) {
        self.apiClient = apiClientWrapper.apiClient
    }

    public func getCertificates() async -> Result<[NMCertificate], GenericError> {
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
