//
//  LocalizationService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

public struct NMLocalization: Decodable, Equatable {
    var language: NMLanguage
    var title: String
    var introduction: String
    var questions: [NMLocalizedQuestion]
    var signature: String
    var yes: String
    var no: String
    var confirm: String
    var eraseSignature: String
    var submit: String
    var cancel: String
    var explanation: String
}

public struct NMLocalizedQuestion: Decodable, Equatable {
    var index: Int
    var formulation: String

    func toQuestion() -> NMQuestion {
        NMQuestion(index: index, formulation: formulation)
    }
}
