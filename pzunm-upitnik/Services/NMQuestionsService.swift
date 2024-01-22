//
//  QuestionsService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public protocol NMQuestionsService {
    func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError>
}

public protocol NMQuestionsRepository {
    func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError>
}

public final class NMQuestionsServiceMock: NMQuestionsService {
    private let repository: NMQuestionsRepository
    
    init(repository: NMQuestionsRepository) {
        self.repository = repository
    }
    
    public func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError> {
        await repository.getQuestions(for: language)
    }
}
