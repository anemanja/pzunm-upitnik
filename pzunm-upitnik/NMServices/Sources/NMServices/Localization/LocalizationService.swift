//
//  LocalizationKeys.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import Foundation
import NMModel

public protocol LocalizationServiceProtocol {
    func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError>
}

public class LocalizationService: LocalizationServiceProtocol {
    private let localizationRepository: any LocalizationRepositoryProtocol

    public init(localizationRepository: any LocalizationRepositoryProtocol) {
        self.localizationRepository = localizationRepository
    }

    public func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError> {
        self.localizationRepository.localization(for: language)
    }
}


