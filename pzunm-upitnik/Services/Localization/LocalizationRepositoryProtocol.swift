//
//  LocalizationRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.2.24..
//

import Foundation

public protocol LocalizationRepositoryProtocol {
    func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError>
}
