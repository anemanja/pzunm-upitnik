//
//  pzunm_upitnikApp.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 31.10.23..
//

import SwiftUI

@main
struct pzunm_upitnikApp: App {
    private var repositories = MockRepositoryModule()
    private var services: ServiceModule
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environmentObject(CoordinatorViewModel())
                .environmentObject(NMAuthenticationViewModel(
                    authenticationService: services.authentication
                ))
                .environmentObject(NMClientsViewModel(
                    clientsService: services.clients
                ))
                .environmentObject(NMQuestionnaireViewModel(
                    questionsService: services.questions,
                    pdfService: services.pdf
                ))
        }
    }
    
    init() {
        self.services = ServiceModule(
            authentication: NMAuthenticationServiceImplementation(repository: repositories.authentication),
            clients: NMClientsServiceImplementation(repository: repositories.clients),
            questions: NMQuestionsServiceMock(repository: repositories.questions),
            pdf: NMPDFServiceImplementation(repository: repositories.pdf)
        )
    }
}
