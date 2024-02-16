//
//  LocalizationKeys.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import Foundation


public protocol LocalizationRepositoryProtocol {
    func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError>
}

public protocol LocalizationServiceProtocol {
    func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError>
}

class LocalizationService: LocalizationServiceProtocol {
    private let localizationRepository: any LocalizationRepositoryProtocol

    init(localizationRepository: any LocalizationRepositoryProtocol) {
        self.localizationRepository = localizationRepository
    }

    func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError> {
        self.localizationRepository.localization(for: language)
    }
}

public enum NMLocalizationKey {
    case language
    case title
    case introduction
    case questions(Int)
    case signature
    case yes
    case no
    case confirm
    case eraseSignature
    case submit
    case cancel
    case explanation
}


