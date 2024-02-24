//
//  QuestionnaireView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import SwiftUI
import PencilKit
import NMModel

struct QuestionnaireView: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    @ObservedObject private var viewModel: QuestionnaireViewModel
    
    @State private var certificate: NMCertificate
    @State private var shouldDisableScrolling = false
    @State private var shouldShowButtons = false
    @State private var offsetIteration: CGFloat = 0.0
    @State private var currentExplanation = ""

    init(viewModel: QuestionnaireViewModel, certificate: NMCertificate, shouldShowButtons: Bool = false, offsetIteration: CGFloat = 0.0, currentExplanation: String = "") {
        self.viewModel = viewModel
        self.certificate = certificate
        self.offsetIteration = offsetIteration
        self.currentExplanation = currentExplanation
    }

    var body: some View {
        LoadingView(source: viewModel) {
            Color.nmBackground
        } loader: { _ in
            NMProgressView()
        } error: { error in
            ErrorView(error) {
                viewModel.fillQuestionnaire(for: certificate.language)
            }
        } content: { localization in
            VStack {

                Text (localization.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.nmTitle)

                GeometryReader { gp in
                    HStack (alignment: .top, spacing: 0) {

                        IntroductionView(introduction: localization.introduction, confirm: localization.confirm, nextAction: {
                            nextQuestion()
                        }, skipAction: {
                            skipQuestions()
                        })
                        .padding()
                        .frame(width: gp.size.width)

                        ForEach(localization.questions, id: \.index) { question in
                            QuestionView(index: question.index,
                                         question: question.formulation,
                                         yesLabelText: localization.yes,
                                         noLabelText: localization.no,
                                         explanationPlaceholderText: localization.explanation,
                                         onAllowedToContinue: nextQuestion)
                            .padding()
                            .frame(width: gp.size.width)
                        }

                        SignatureView(signature: localization.signature,
                                      name: certificate.name, surname: certificate.surname,
                                      eraseSignature: localization.eraseSignature,
                                      confirm: localization.confirm,
                                      done: done(with:))
                        .padding()
                        .frame(width: gp.size.width)
                    }
                    .offset(x: -gp.size.width * offsetIteration)
                }
                .frame(height: 460.0)

                Spacer()
                HStack {
                    ForEach(viewModel.currentQuestionIndicators.indices, id: \.hashValue) { index in
                        ToggleView(isOn: $viewModel.currentQuestionIndicators[index],
                                   enabled: false,
                                   text: "\(index + 1)", imageSystemName: "rectangle",
                                   primaryColor: .nmPrimary,
                                   secondaryColor: .nmPrimary,
                                   shadowColor: .clear,
                                   fontSize: 20.0,
                                   textColor: .nmPrimary,
                                   backgroundColor: .nmTextBackground) {}
                    }
                }
                .frame(height: 30.0)
            }
            .padding(37.1)
            .background(Color.nmBackground)
        }
        .onAppear {
            viewModel.fillQuestionnaire(for: certificate.language)
        }
    }
    
    // MARK: Questions
    
    func nextQuestion(answer: Bool? = nil, explanation: String? = nil) {
        if let explanation = explanation, let answer = answer {
            viewModel.confirmCurrent(answer: answer, explanation: explanation)
        }
        viewModel.cycleToNextQuestion()
        currentExplanation = ""
        withAnimation {
            offsetIteration += 1.0
        }
    }

    func skipQuestions() {
        let skippedQuestionsCount = viewModel.skipAllQuestions()
        withAnimation {
            offsetIteration += 1.0 * CGFloat(skippedQuestionsCount)
        }
    }
    
    func done(with signatureImage: Image) {
        if let preview = viewModel.questionnairePreview(for: certificate.idString(),
                                                        with: signatureImage) {
            coordinatorViewModel.cover(with: preview)
        }
    }
}
