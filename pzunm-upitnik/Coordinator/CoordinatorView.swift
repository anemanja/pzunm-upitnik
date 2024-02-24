//
//  CoordinatorView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI
import NMModel

struct CoordinatorView: View {
    @EnvironmentObject private var viewModel: CoordinatorViewModel
    private var dependencyContainer: DependencyContainer

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            MainView() { isAuthenticated in
                CertificatesView(viewModel: dependencyContainer.certificatesViewModel,
                                 shouldShowAll: isAuthenticated)
            } authenticationView: { isAuthenticated in
                AuthenticationView(viewModel: dependencyContainer.authenticationViewModel,
                                   isAuthenticated: isAuthenticated)
            }
                .navigationDestination(for: NMCertificate.self) { certificate in
                    if certificate.language == nil {
                        LanguagesView(certificate: certificate)
                    } else {
                        QuestionnaireView(viewModel: dependencyContainer.questionnaireViewModel,
                                          certificate: certificate)
                    }
                }
        }
        .fullScreenCover(isPresented: $viewModel.shouldCover) {
            if let coverData = viewModel.questionnairePreviewCoverData {
                PDFSubmitView(viewModel: dependencyContainer.pdfSubmitViewModel, submitLabel: coverData.submitLabel, cancelLabel: coverData.cancelLabel, certificateId: coverData.certificateId) {
                    QuestionnairePreviewView(questionnairePreview: coverData)
                }
            } else {
                Text("Invalid view data.")
            }
        }
    }
}
