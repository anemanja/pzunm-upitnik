//
//  QuestionnaireViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import SwiftUI
import NMServices
import NMModel

class QuestionnaireViewModel: LoadingObject {
    @Published private(set) var state = LoadingState<NMLocalization>.idle
    @Published var currentQuestionIndicators: [Bool] = []

    private var localizationService: any LocalizationServiceProtocol

    private var questions: [NMQuestion] = []
    private var currentQuestion = 0
    private var localization: NMLocalization?

    init(localizationService: any LocalizationServiceProtocol) {
        self.localizationService = localizationService
    }

    func fillQuestionnaire(for language: NMLanguage?) {
        guard let language = language else { return }

        state = .loading(0.0)
        let result = localizationService.localization(for: language)
        switch result {
        case .success(let localization):
            questions = localization.questions.map { $0.toQuestion()}
            self.localization = localization
            currentQuestionIndicators = questions.map { _ in true }
            state = .loaded(localization)
        case .failure(let error):
            state = .failed(error)
        }
    }

    func cycleToNextQuestion() {
        let current = currentQuestionIndicators.firstIndex(of: false) ?? -1
        setCurrent(to: current)
    }

    func skipAllQuestions() -> Int {
        let skippedStepsCount = questions.count + 1
        questions = questions.map { NMQuestion(index: $0.index, formulation: $0.formulation, answer: .no) }
        currentQuestion = skippedStepsCount
        return skippedStepsCount
    }
    
    func setCurrent(to index: Int) {
        if index >= 0 {
            currentQuestionIndicators[index] = true
        }
        
        if index + 1 < currentQuestionIndicators.endIndex {
            currentQuestionIndicators[index + 1] = false
        }
        
        currentQuestion = index + 1        
    }
    
    func confirmCurrent(answer: Bool, explanation: String) {
        if currentQuestion < questions.count {
            questions[currentQuestion].answer = answer ? .yes : .no
            questions[currentQuestion].explanation = explanation
        }
    }

    func questionnairePreview(for certificateId: String, with signatureView: Image) -> NMQuestionnairePreview? {
        guard let preview = localization?.preview(for: certificateId, with: questions, and: signatureView) else {
            state = .failed(.customError(message: "Failed to create Questionnaire Preview."))
            return nil
        }
        return preview
    }
}
