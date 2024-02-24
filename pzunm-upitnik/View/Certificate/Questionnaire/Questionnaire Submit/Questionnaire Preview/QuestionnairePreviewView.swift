//
//  QuestionnairePreviewView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI
import NMModel

struct QuestionnairePreviewView: View {
    private var questionnairePreview: NMQuestionnairePreview

    init(questionnairePreview: NMQuestionnairePreview) {
        self.questionnairePreview = questionnairePreview
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                // TODO: Add timestamp
                Text("PZU NAŠA MEDICINA v\(Bundle.main.releaseVersionNumber).\(Bundle.main.buildVersionNumber)")
                    .foregroundColor(.nmPrimary)
                    .font(.system(size: 12.0, weight: .bold, design: .serif))
                Spacer()
                Text(questionnairePreview.certificateId)
                    .font(.system(size: 12.0))
                    .fontDesign(.monospaced)
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 5.0)

            HStack {
                Spacer()
                Text(questionnairePreview.title)
                    .font(.system(size: 12.0, weight: .bold, design: .serif))
                    .textCase(.uppercase)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.bottom, 5.0)

            Text(questionnairePreview.introduction)
                .font(.system(size: 9.0, weight: .ultraLight, design: .serif))
                .padding(.bottom, 5.0)

            ForEach(questionnairePreview.questions, id: \.hashValue) { question in
                QuestionPreviewView(question: question,
                                    yesLabel: questionnairePreview.yesLabel,
                                    noLabel: questionnairePreview.noLabel)
                .listRowSeparatorTint(.black)
            }
            .listStyle(.plain)

            Spacer()

            HStack {
                Spacer()
                questionnairePreview.signatureView
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }
        }
        .frame(width: 550, height: 800)
        .padding()
    }
}
