//
//  NMClient.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import Foundation

public struct NMClient: Codable, Identifiable, Hashable {
    public var id: String // Protocol Number
    var name: String
    var surname: String
    var language: NMLanguage?
    var hasCompletedQuestionnaire: Bool
}
