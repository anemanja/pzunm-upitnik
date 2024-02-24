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

public final class PDFService: PDFServiceProtocol {
    private var repository: any PDFRepositoryProtocol
    private var questionnaireRepository: any QuestionnaireStatusRepositoryProtocol

    init(repository: any PDFRepositoryProtocol, questionnaireRepository: any QuestionnaireStatusRepositoryProtocol) {
        self.repository = repository
        self.questionnaireRepository = questionnaireRepository
    }
    
    public func uploadPDF(at path: URL, for certificateId: String) async -> Result<Void, GenericError> {
        let result = await repository.uploadPDF(at: path, for: certificateId)
        switch result {
        case .success():
            guard let certificateId = Int(certificateId) else {
                return .failure(.customError(message: "Questionnaire Status Update Error: Failed to convert \(certificateId) to Int."))
            }
            questionnaireRepository.setQuestionnaireStatus(for: certificateId, to: true)
            return .success(())
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
