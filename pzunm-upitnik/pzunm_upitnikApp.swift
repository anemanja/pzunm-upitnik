//
//  pzunm_upitnikApp.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.10.23..
//

import SwiftUI
import Networking

@main
struct pzunm_upitnikApp: App {
    private var repositories: MockRepositoryModule
    private var services: ServiceModule
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(CoordinatorViewModel())
                .environmentObject(AuthenticationViewModel(
                    authenticationService: services.authentication
                ))
                .environmentObject(CertificatesViewModel(
                    certificatesService: services.certificates
                ))
                .environmentObject(QuestionnaireViewModel(
                    pdfService: services.pdf,
                    localizationService: services.localization
                ))
        }
    }
    
    init() {
        // Separate this into a DependancyAssembler class, or something like that.
        let apiClient = APIClient<Endpoint>(dataParser: DataParser.json, responseParser: ResponseParser(), requestBuilder: NMRequestBuilder())
        let certificates = CertificatesRepositoryImplementation(apiClient: apiClient)
        let localization = LocalizationRepository()
        let repositories = MockRepositoryModule(certificates: certificates, localization: localization)

        self.repositories = repositories

        self.services = ServiceModule(
            authentication: AuthenticationService(repository: repositories.authentication),
            certificates: CertificatesService(repository: repositories.certificates),
            pdf: NMPDFServiceImplementation(repository: repositories.pdf),
            localization: LocalizationService(localizationRepository: repositories.localization)
        )
    }
}
