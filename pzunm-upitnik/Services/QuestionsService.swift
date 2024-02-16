//
//  QuestionsService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol QuestionsServiceProtocol {
    func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError>
}

public protocol QuestionsRepositoryProtocol {
    func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError>
}

public final class QuestionsServiceMock: QuestionsServiceProtocol {
    private let repository: QuestionsRepositoryProtocol
    
    init(repository: QuestionsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError> {
        await repository.getQuestions(for: language)
    }
}
