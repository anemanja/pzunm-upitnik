//
//  CoordinatorView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct CoordinatorView: View {
    @EnvironmentObject var viewModel: CoordinatorViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            MainView()
                .navigationDestination(for: NMCertificate.self) { certificate in
                    if certificate.language == nil {
                        LanguagesView(certificate: certificate)
                    } else {
                        QuestionnaireView(viewModel: viewModel.dependencyContainer.questionnaireViewModel,
                                          certificate: certificate)
                    }
                }
        }
        .fullScreenCover(isPresented: $viewModel.shouldCover) {
            if let coverData = viewModel.questionnairePreviewCoverData {
                PDFSubmitView(viewModel: viewModel.dependencyContainer.pdfSubmitViewModel, submitLabel: coverData.submitLabel, certificateId: coverData.certificateId) {
                    QuestionnairePreviewView(questionnairePreview: coverData)
                }
//                    .interactiveDismissDisabled()
            } else {
                Text("Invalid view data.")
            }
        }
    }
}
