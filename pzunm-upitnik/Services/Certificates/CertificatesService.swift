//
//  ClientsService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol CertificatesServiceProtocol {
    func getCertificates(includingCompleted shouldIncludeCompleted: Bool) async -> Result<[NMCertificate], GenericError>
}

public final class CertificatesService: CertificatesServiceProtocol {
    private let repository: any CertificatesRepositoryProtocol
    private let questionnaireRepository: any QuestionnaireStatusRepositoryProtocol

    public init(repository: any CertificatesRepositoryProtocol, questionnaireRepository: any QuestionnaireStatusRepositoryProtocol) {
        self.repository = repository
        self.questionnaireRepository = questionnaireRepository
    }
    
    public func getCertificates(includingCompleted shouldIncludeCompleted: Bool = false) async -> Result<[NMCertificate], GenericError> {
        let result = await repository.getCertificates()
        switch result {
        case .success(let receivedCertificates):
            var certificates = receivedCertificates.filter { $0.type != .sport }
            let questionnaireStatuses = questionnaireRepository.getQuestionnaireStatus(for: certificates.map { $0.id })
            certificates = certificates.map {
                NMCertificate(id: $0.id,
                              name: $0.name,
                              surname: $0.surname,
                              language: $0.language,
                              hasCompletedQuestionnaire: questionnaireStatuses[$0.id] ?? false,
                              type: $0.type)
            }

            if !shouldIncludeCompleted {
                return .success(certificates.filter { !$0.hasCompletedQuestionnaire })
            } else {
                return .success(certificates)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

