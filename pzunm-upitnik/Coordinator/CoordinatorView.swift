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
            NMMainView()
                .navigationDestination(for: NMClient.self) { client in
                    if client.language == nil {
                        NMLanguagesView(client: client)
                    } else {
                        NMQuestionnaireView(client: client)
                    }
                }
        }
        .fullScreenCover(isPresented: $viewModel.shouldCover) {
            if let coverData = viewModel.questionnairePreviewCoverData {
                NMQuestionnairePreviewView(questionnairePreview: coverData)
                    .interactiveDismissDisabled()
            } else {
                Text("Invalid view data.")
            }
        }
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
            .previewDevice("iPad mini (6th generation)")
            .environmentObject(CoordinatorViewModel())
    }
}
