//
//  DependencyAssembler.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 23.2.24..
//

import Foundation
import NMServices
import NMRepository

struct DependencyContainer {
    let authenticationViewModel: AuthenticationViewModel
    let certificatesViewModel: CertificatesViewModel
    let questionnaireViewModel: QuestionnaireViewModel
    let pdfSubmitViewModel: PDFSubmitViewModel
}

protocol DependencyAssemblerProtocol {
    func assemble() -> DependencyContainer
}

class DependencyAssembler: DependencyAssemblerProtocol {
    func assemble() -> DependencyContainer {
        let apiClient = NMAPIClientWrapper()
        let questionnaireStatusRepository = QuestionnaireStatusRepository()

        return DependencyContainer(authenticationViewModel: authentication(),
                                   certificatesViewModel: certificates(with: apiClient, questionnaireStatusRepository: questionnaireStatusRepository),
                                   questionnaireViewModel: questionnaire(),
                                   pdfSubmitViewModel: pdfSubmit(with: apiClient, questionnaireStatusRepository: questionnaireStatusRepository))
    }

    private func authentication() -> AuthenticationViewModel {
        let authenticationRepository = AuthenticationRepository()
        let authenticationService = AuthenticationService(repository: authenticationRepository)
        return AuthenticationViewModel(authenticationService: authenticationService)
    }

    private func certificates(with apiClient: NMAPIClientWrapper, questionnaireStatusRepository: any QuestionnaireStatusRepositoryProtocol) -> CertificatesViewModel {
        let certificatesRepository = CertificatesRepository(apiClientWrapper: apiClient)
        let certificatesService = CertificatesService(repository: certificatesRepository, questionnaireRepository: questionnaireStatusRepository)
        return CertificatesViewModel(certificatesService: certificatesService)
    }

    private func questionnaire() -> QuestionnaireViewModel {
        let localizationRepository = LocalizationRepository()
        let localizationService = LocalizationService(localizationRepository: localizationRepository)
        return QuestionnaireViewModel(localizationService: localizationService)
    }

    private func pdfSubmit(with apiClient: NMAPIClientWrapper, questionnaireStatusRepository: any QuestionnaireStatusRepositoryProtocol) -> PDFSubmitViewModel {
        let pdfRepository = PDFRepository(apiClientWrapper: apiClient)
        let pdfService = PDFService(repository: pdfRepository, questionnaireRepository: questionnaireStatusRepository)
        return PDFSubmitViewModel(pdfService: pdfService)
    }
}
