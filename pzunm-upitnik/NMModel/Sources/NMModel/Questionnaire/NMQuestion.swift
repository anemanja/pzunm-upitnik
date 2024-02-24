//
//  NMQuestion.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import Foundation

public struct NMQuestion: Identifiable, Hashable, Codable {
    private static var count = 0
    
    public let id: Int
    public let index: Int
    public let formulation: String
    public var answer: NMAnswer = .none
    public var explanation: String
    
    public init(index: Int, formulation: String, answer: NMAnswer = .none, explanation: String = "") {
        NMQuestion.incrementCount()
        self.id = NMQuestion.count
        self.index = index
        self.formulation = formulation
        self.answer = answer
        self.explanation = explanation
    }
    
    private static func incrementCount() {
        count += 1
    }
}

public enum NMAnswer: Codable {
    case yes
    case no
    case none
    
    public var text: String {
        switch self {
        case .yes:
            return "DA"
        case .no:
            return "NE"
        case .none:
            return ""
        }
    }
}

public struct NMQuestionnaire: Codable {
    let language: NMLanguage
    let title: String
    let introduction: String
    var questions: [NMQuestion]

    public init(with localization: NMLocalization) {
        self.language = localization.language
        self.title = localization.title
        self.introduction = localization.introduction
        self.questions = localization.questions.map{ $0.toQuestion() }
    }
}


