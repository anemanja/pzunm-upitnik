//
//  QuestionsRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public final class MockClientsRepository: CertificatesRepositoryProtocol {
    public func getCertificates() async -> Result<[NMCertificate], GenericError> {
        return .success([
            NMCertificate(id: "0012301", ime: "Murat", prezime: "Osmanoglu",
                     language: .tur, hasCompletedQuestionnaire: false),
            NMCertificate(id: "0233540", ime: "Berat", prezime: "Krasnichi",
                     language: .alb, hasCompletedQuestionnaire: true),
            NMCertificate(id: "0003153", ime: "Radovan", prezime: "Berović",
                     language: .srb, hasCompletedQuestionnaire: false),
            NMCertificate(id: "1125003", ime: "Osman", prezime: "Jagluk",
                     language: .tur, hasCompletedQuestionnaire: true),
            NMCertificate(id: "0002318", ime: "Vukomir", prezime: "Avramović",
                     language: .srb, hasCompletedQuestionnaire: false)
        ])
    }
}

public final class MockAuthenticationRepository: AuthenticationRepositoryProtocol {
    public func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError> {
        if username == "admin" && password == "admin" {
            return .success(())
        }
        
        return .failure(GenericError.customError(message: "Wrong Credentials."))
    }
}

public final class MockPDFRepository: PDFRepositoryProtocol {
    public func uploadPDF(at path: URL, for clientId: String) async -> Result<Void, GenericError> {
        .success(())
    }
}

public final class MockLocalizationRepository: LocalizationRepositoryProtocol {
    public func localization(for language: NMLanguage) -> Result<NMLocalization, GenericError> {
        .success(NMLocalization(language: NMLanguage.srb, title: "UPITNIK", introduction: "UPITNIK ZA PODNOSIOCA ZAHTJEVA ZA LJEKARSKO UVJERENJE", questions: [], signature: "Potpis", yes: "DA", no: "NE", confirm: "Potvrdi", eraseSignature: "Makni potpis", submit: "Predaj", cancel: "Odustani", explanation: "Objašnjenje"))
    }
}

public class MockRepositoryModule {
    public let authentication: any AuthenticationRepositoryProtocol
    public let certificates: any CertificatesRepositoryProtocol
    public let pdf: any PDFRepositoryProtocol
    public let localization: any LocalizationRepositoryProtocol

    init(authentication: any AuthenticationRepositoryProtocol = MockAuthenticationRepository(),
         certificates: any CertificatesRepositoryProtocol = MockClientsRepository(),
         pdf: any PDFRepositoryProtocol = MockPDFRepository(),
         localization: any LocalizationRepositoryProtocol = MockLocalizationRepository()
    ) {
        self.authentication = authentication
        self.certificates = certificates
        self.pdf = pdf
        self.localization = localization
    }
}
