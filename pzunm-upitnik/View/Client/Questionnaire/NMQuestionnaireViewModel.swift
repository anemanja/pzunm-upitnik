//
//  NMQuestionnaireViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import Foundation

class NMQuestionnaireViewModel: ObservableObject {
    @Published var questionnaire = NMQuestionnaire.emptyValue
    @Published var progress = ProgressTracker()
    
    private var questionsService: any NMQuestionsService
    private var pdfService: any NMPDFService
    
    init(questionsService: any NMQuestionsService, pdfService: any NMPDFService) {
        self.questionsService = questionsService
        self.pdfService = pdfService
    }
    
    func fillQuestionnaire(for language: NMLanguage) {
        Task {
            progress.start()
            let result = await questionsService.getQuestions(for: language)
            switch result {
            case .success(let questionnaire):
                self.questionnaire = questionnaire
                self.progress.reset()
            case .failure(let error):
                self.questionnaire = NMQuestionnaire.defaultValue
                self.progress.failed(with: error)
            }
        }
    }
    
    func getPDFPath(for clientId: String) -> URL {
        URL.documentsDirectory.appending(path: "\(clientId).pdf")
    }
    
    func sendPDF(for clientId: String) {
        Task {
            progress.start()
            let result = await pdfService.uploadPDF(at: getPDFPath(for: clientId), for: clientId)
            switch result {
            case .success:
                self.progress.reset()
            case .failure(let error):
                self.progress.failed(with: error)
            }
        }
    }
}
