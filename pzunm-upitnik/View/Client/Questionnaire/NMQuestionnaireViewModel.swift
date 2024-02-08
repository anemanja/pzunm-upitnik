//
//  NMQuestionnaireViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import Foundation

class NMQuestionnaireViewModel: ObservableObject {
    @Published var questionnaire = NMQuestionnaire.emptyValue
    @Published var currentQuestionIndicators: [Bool] = []
    @Published var currentQuestion = 0
    
    private var questionsService: any NMQuestionsService
    private var pdfService: any NMPDFService
    
    private var currentQuestionExplanation = ""
    
    init(questionsService: any NMQuestionsService, pdfService: any NMPDFService) {
        self.questionsService = questionsService
        self.pdfService = pdfService
    }
    
    func fillQuestionnaire(for language: NMLanguage) {
        Task {
            let result = await questionsService.getQuestions(for: language)
            await MainActor.run {
                switch result {
                case .success(let questionnaire):
                    self.questionnaire = questionnaire
                    self.currentQuestionIndicators = questionnaire.questions.map { _ in true }
                case .failure(_):
                    self.questionnaire = NMQuestionnaire.defaultValue
                }
            }
        }
    }
    
    func cycleToNextQuestion() {
        let current = currentQuestionIndicators.firstIndex(of: false) ?? -1
        setCurrent(to: current)
    }
    
    func setCurrent(to index: Int) {
        if index >= 0 {
            currentQuestionIndicators[index] = true
        }
        
        if index + 1 < currentQuestionIndicators.endIndex {
            currentQuestionIndicators[index + 1] = false
        }
        
        currentQuestion = index + 1
        
        print("o=C=====>\t\(index)")
    }
    
    func confirmCurrent(explanation: String) {
        questionnaire.questions[currentQuestion].explanation = explanation
    }
    
    func getPDFPath(for clientId: String) -> URL {
        URL.documentsDirectory.appending(path: "\(clientId).pdf")
    }
    
    func sendPDF(for clientId: String) {
//        Task {
//            let result = await pdfService.uploadPDF(at: getPDFPath(for: clientId), for: clientId)
//            await MainActor.run {
//                switch result {
//                case .success:
//                case .failure(let error):
//                }
//            }
//        }
    }
}
