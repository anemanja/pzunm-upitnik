//
//  QuestionnaireViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import Foundation

class QuestionnaireViewModel: LoadingObject {
    @Published private(set) var state = LoadingState<NMLocalization>.idle
    @Published var questions: [NMQuestion] = []
    @Published var title: String = ""
    @Published var introduction: String = ""
    @Published var currentQuestionIndicators: [Bool] = []
    @Published var currentQuestion = 0
    
    private var pdfService: any PDFServiceProtocol
    private var localizationService: any LocalizationServiceProtocol
    
    private var currentQuestionExplanation = ""
    
    init(pdfService: any PDFServiceProtocol, localizationService: any LocalizationServiceProtocol) {
        self.pdfService = pdfService
        self.localizationService = localizationService
    }
    
    func fillQuestionnaire(for language: NMLanguage?) {
        guard let language = language else { return }

        state = .loading(0.0)
        let localizationRepository = LocalizationRepository()
        let result = localizationRepository.localization(for: language)
        switch result {
        case .success(let localization):
            questions = localization.questions.map { NMQuestion(formulation: $0) }
            title = localization.title
            introduction = localization.introduction
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
        questions[currentQuestion].explanation = explanation
    }
    
    func getPDFPath(for certificateId: String) -> URL {
        URL.documentsDirectory.appending(path: "\(certificateId).pdf")
    }
    
    func sendPDF(for certificateId: String) {
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
