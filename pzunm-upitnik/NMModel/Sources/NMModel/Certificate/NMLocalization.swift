//
//  LocalizationService.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 10.2.24..
//

import Foundation

public struct NMLocalization: Decodable, Equatable {
    public let language: NMLanguage
    public let title: String
    public let introduction: String
    public let questions: [NMLocalizedQuestion]
    public let signature: String
    public let yes: String
    public let no: String
    public let confirm: String
    public let eraseSignature: String
    public let submit: String
    public let cancel: String
    public let explanation: String
}

public struct NMLocalizedQuestion: Decodable, Equatable {
    public let index: Int
    public let formulation: String

    public func toQuestion() -> NMQuestion {
        NMQuestion(index: index, formulation: formulation)
    }
}
