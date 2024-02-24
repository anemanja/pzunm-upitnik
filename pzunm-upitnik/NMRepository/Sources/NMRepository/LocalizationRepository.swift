//
//  LocalizationRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 15.2.24..
//

import Foundation
import UIKit
import NMServices
import NMModel

public class LocalizationRepository: LocalizationRepositoryProtocol {
    private var localizations: [NMLanguage: NMLocalization]

    public init() {
        localizations = [:]
        for language in NMLanguage.allCases {
            if let data = NSDataAsset(name: language.rawValue)?.data {
                do {
                    let localization = try JSONDecoder().decode(NMLocalization.self, from: data)
                    localizations[language] = localization
                } catch let error {
                    print("Error decoding language data for \(language.rawValue): " + String(describing: error))
                }
            } else {
                print("Error: Could not find language data for \(language.rawValue).")
            }
        }
    }

    public func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError> {
        guard let localization = localizations[language] else {
            return .failure(GenericError.customError(message: "Localization Failed"))
        }
        return .success(localization)
    }
}
