//
//  NMQuestionnairePreviewView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI

struct NMQuestionnairePreviewView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: NMQuestionnaireViewModel
    
    @State var questionnairePreview: NMQuestionnairePreview
    
    var body: some View {
        VStack {
            VStack {
                Text(questionnairePreview.questionnaire.title)
                Text(questionnairePreview.questionnaire.introduction)
                    .padding()
                List(questionnairePreview.questionnaire.questions, id: \.hashValue) { question in
                    HStack (alignment: .top) {
                        Text(String(1 + (questionnairePreview.questionnaire.questions.firstIndex(of: question) ?? 0)) + ".")
                        NMQuestionPreviewView(question: question)
                            .listRowSeparatorTint(.black)
                    }
                }
                .listStyle(.plain)
                Group {
                    Text("Svojerucni potpis:")
                    questionnairePreview.signatureView
                }
                .padding()
            }
            .padding()
            .border(.black)
            Button("Predaj", action: submit)
                .buttonStyle(.borderedProminent)
                .accentColor(.red)
        }
        .padding(.horizontal)
    }
    
    func submit() {
        viewModel.sendPDF(for: questionnairePreview.clientId)
    }
}

struct NMQuestionnairePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        NMQuestionnairePreviewView(questionnairePreview: NMQuestionnairePreview(clientId: "003210", questionnaire: NMQuestionnaire(language: .srb, title: "Upitnik", introduction: "Intro", questions: [
            NMQuestion(formulation: "Kojekude?", answer: .yes, explanation: "Kojekude..."),
            NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .yes, explanation: "Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira."),
            NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .no, explanation: "Urinirao na vratima javne ustanove."),
            NMQuestion(formulation: "Kojekude?", answer: .no, explanation: "Kojekude...")
        ]), signatureView: Image(systemName: "signature"))
        )
        .environmentObject(NMQuestionnaireViewModel(questionsService: NMQuestionsServiceMock(repository: MockRepositoryModule().questions), pdfService: NMPDFServiceImplementation(repository: MockRepositoryModule().pdf)))
    }
}
