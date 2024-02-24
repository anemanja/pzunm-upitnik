//
//  NMClient.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import Foundation

public struct NMCertificate: Codable, Identifiable, Hashable {
    public var id: Int
    public var name: String
    public var surname: String
    public var language: NMLanguage?
    public var hasCompletedQuestionnaire: Bool
    public var type: NMCertificateType

    enum CodingKeys: String, CodingKey {
        case id = "idUvjerenja"
        case name = "ime"
        case surname = "prezime"
        case language
        case hasCompletedQuestionnaire
        case type = "opis"
    }

    public init(id: Int, name: String, surname: String, language: NMLanguage?, hasCompletedQuestionnaire: Bool, type: NMCertificateType) {
        self.id = id
        self.name = name
        self.surname = surname
        self.hasCompletedQuestionnaire = hasCompletedQuestionnaire
        self.type = type
    }

    public init(id: String, name: String, surname: String, language: NMLanguage? = .srb, hasCompletedQuestionnaire: Bool, type: NMCertificateType? = .other) {
        self.id = Int(id) ?? 0
        self.name = name
        self.surname = surname
        self.hasCompletedQuestionnaire = hasCompletedQuestionnaire
        self.type = type ?? .other
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.language = try container.decodeIfPresent(NMLanguage.self, forKey: .language)
        self.hasCompletedQuestionnaire = try container.decodeIfPresent(Bool.self, forKey: .hasCompletedQuestionnaire) ?? false
        self.type = (try? container.decode(NMCertificateType.self, forKey: .type)) ?? .other
    }

    public func idString() -> String {
        String(format: "%05d", id)
    }
}
