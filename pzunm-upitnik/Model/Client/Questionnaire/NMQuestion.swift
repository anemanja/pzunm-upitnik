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
    let formulation: String
    var answer: NMAnswer = .none
    var explanation: String
    
    init(formulation: String, answer: NMAnswer = .none, explanation: String = "") {
        NMQuestion.incrementCount()
        self.id = NMQuestion.count
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
    
    public static let emptyValue = NMQuestionnaire(language: .srb,
                                                   title: "",
                                                   introduction: "",
                                                   questions: [])
    
    public static let defaultValue = NMQuestionnaire(language: .srb,
                                                     title: "UPITNIK ZA PODNOSIOCA ZAHTJEVA ZA LJEKARSKO UVJERENJE",
                                                     introduction: "Postovani, ovo je upitnik koji nam pruža uvid u vaše prethodno zdravstveno stanje. Molimo vas da pažljivo pročitate pitanja i iskreno odgovorite zaokruzivanjem tačnog odgovora. Ukoliko je odgovor na pitanje pozitivan, objasnite detaljnije na praznoj liniji ispod odgovora. Vjerodostojnost vašeg odgovora garantujete svojeručnim potpisom.",
                                                     questions: [
                                                        NMQuestion(formulation: "Da li ste imali ili imate neku prirodnu ili stečenu bolest organa vida?"),
                                                        NMQuestion(formulation: "Da li ste imali ili imate urođene ili stečene bolesti organa sluha ili ravnoteže?"),
                                                        NMQuestion(formulation: "Da li bolujete od neke duševne bolesti?"),
                                                        NMQuestion(formulation: "Da li ste bolovali ili bolujete od neke bolesti zavisnosti (alkoholizam, toksikomanija, zloupotreba psihotropnih supstanci)"),
                                                        NMQuestion(formulation: "Da li bolujete od epilepsije ili nekih drugih poremećaja svijesti?"),
                                                        NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?")
                                                     ])
}


