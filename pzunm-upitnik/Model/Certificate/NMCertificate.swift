//
//  NMClient.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import Foundation

public struct NMCertificate: Codable, Identifiable, Hashable {
    public var id: String // Certificate Protocol Number
    var ime: String
    var prezime: String
    var language: NMLanguage?
    var hasCompletedQuestionnaire: Bool

    enum CodingKeys: String, CodingKey {
        case id = "idUvjerenja"
        case ime
        case prezime
        case language
        case hasCompletedQuestionnaire
    }

    init(id: String, ime: String, prezime: String, language: NMLanguage? = .srb, hasCompletedQuestionnaire: Bool) {
        self.id = id//Int(id) ?? 0
        self.ime = ime
        self.prezime = prezime
        self.hasCompletedQuestionnaire = hasCompletedQuestionnaire
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.ime = try container.decode(String.self, forKey: .ime)
        self.prezime = try container.decode(String.self, forKey: .prezime)
        self.language = try container.decodeIfPresent(NMLanguage.self, forKey: .language)
        self.hasCompletedQuestionnaire = try container.decodeIfPresent(Bool.self, forKey: .hasCompletedQuestionnaire) ?? false
    }

    func idString() -> String {
        id //String(format: "%05d", id)
    }
}
