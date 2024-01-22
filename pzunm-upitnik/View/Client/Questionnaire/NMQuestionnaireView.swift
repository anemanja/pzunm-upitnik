//
//  NMQuestionnaireView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import SwiftUI

struct NMQuestionnaireView: View {
    @State var client: NMClient
    @EnvironmentObject var viewModel: NMQuestionnaireViewModel
    
    var body: some View {
        VStack {
            Text (viewModel.questionnaire.title)
            Form {
                Section {
                    Text(viewModel.questionnaire.introduction)
                }
                Section("Questions") {
                    ForEach($viewModel.questionnaire.questions) { $question in
                        NMQuestionView(question: $question)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fillQuestionnaire(for: .srb)
        }
    }
}

struct NMQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        NMQuestionnaireView(client: NMClient(id: "001037",
                                         name: "Nemanja", surname: "Avramović",
                                         language: nil,
                                         hasCompletedQuestionnaire: false))
        .environmentObject(NMQuestionnaireViewModel(questionsService: NMQuestionsServiceMock(repository: MockRepositoryModule().questions), pdfService: NMPDFServiceImplementation(repository: MockRepositoryModule().pdf)))
        
    }
}
