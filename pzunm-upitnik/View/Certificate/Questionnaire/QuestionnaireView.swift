//
//  QuestionnaireView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import SwiftUI
import PencilKit

struct QuestionnaireView: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @EnvironmentObject var viewModel: QuestionnaireViewModel
    
    @State var certificate: NMCertificate
    @State var canvasView = PKCanvasView()
    @State var shouldDisableScrolling = false
    @State var shouldShowButtons = false
    @State var offsetIteration: CGFloat = 0.0
    @State var currentExplanation = ""

    var body: some View {
        LoadingView(source: viewModel) {
            Color.nmBackground
                .onAppear {
                    viewModel.fillQuestionnaire(for: certificate.language)
                }
        } loader: { _ in
            ProgressView()
        } error: { error in
            // TODO: Extract to a separate view. CertificatesView will also use it
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 50.0)
                Text(error.description)
                    .padding()
            }
            .foregroundColor(.nmError)
        } content: { localization in
            VStack {

                Text (localization.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.nmTitle)

                GeometryReader { gp in
                    HStack (alignment: .top, spacing: 0) {

                        VStack {
                            CardView { _ in
                                Text(localization.introduction)
                                    .font(.title)
                                    .padding(.horizontal, 50.0)
                                    .foregroundColor(.nmTitle)
                                    .multilineTextAlignment(.center)
                            }

                            Button(localization.confirm) {
                                nextQuestion()
                            }
                            .buttonStyle(.borderedProminent)
                            .accentColor(.nmTitle)
                        }
                        .padding()
                        .frame(width: gp.size.width)

                        ForEach($viewModel.questions, id: \.hashValue) { $question in
                            QuestionView(answer: $question.answer,
                                         explanation: $currentExplanation,
                                         index: question.id,
                                         question: question.formulation,
                                         yesLabelText: localization.yes,
                                         noLabelText: localization.no,
                                         explanationPlaceholderText: localization.explanation,
                                         onAllowedToContinue: nextQuestion)
                            .padding()
                            .frame(width: gp.size.width)
                        }

                        ZStack (alignment: .top) {
                            CardView { _ in
                                VStack{
                                    SectionHeaderView(text: localization.signature)
                                        .foregroundColor(.nmPrimary)
                                    CanvasView(canvasView: $canvasView, onSaved: onSaved, onBegan: onBegan, onEnded: onEnded)
                                        .border(Color.nmBackground)
                                    Text(certificate.ime + " " + certificate.prezime)
                                        .font(.title2)
                                        .padding()
                                }
                                .padding()
                            }
                            .padding(.bottom, 50.0)
                            .frame(maxHeight: 300.0)

                            VStack {
                                Spacer()

                                HStack {
                                    if shouldShowButtons {
                                        Button(localization.eraseSignature, action: deleteDrawing)
                                            .buttonStyle(.bordered)
                                            .accentColor(.nmTitle)
                                        Button(localization.confirm, action: done)
                                            .buttonStyle(.borderedProminent)
                                            .accentColor(.nmTitle)
                                    }
                                }
                            }
                        }
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
            .onAppear {
                viewModel.fillQuestionnaire(for: .srb)
            }
        }
    }
    
    // MARK: Questions
    
    func nextQuestion() {
        viewModel.confirmCurrent(explanation: currentExplanation)
        viewModel.cycleToNextQuestion()
        currentExplanation = ""
        withAnimation {
            offsetIteration += 1.0
        }
    }
    
    // MARK: Canvas
    
    func onSaved() {
        shouldShowButtons = true
    }
    
    func onBegan() {
        shouldDisableScrolling = true
    }
    
    func onEnded() {
        shouldDisableScrolling = false
    }
    
    func deleteDrawing() {
        shouldShowButtons = false
        canvasView.drawing = PKDrawing()
    }
    
    func done() {
        coordinatorViewModel.cover(with: NMQuestionnairePreview(certificateId: certificate.idString(),
                                                                title: viewModel.title,
                                                                introduction: viewModel.introduction,
                                                                questions: viewModel.questions,
                                                                signatureView: Image(uiImage: canvasView.drawing.image(from: canvasView.bounds, scale: 1.0))))
    }
}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(certificate: NMCertificate(id: "001037",
                                         ime: "Nemanja", prezime: "Avramović",
                                         language: nil,
                                         hasCompletedQuestionnaire: false))
        .environmentObject(QuestionnaireViewModel(pdfService: NMPDFServiceImplementation(repository: MockRepositoryModule().pdf), localizationService: LocalizationService(localizationRepository: MockLocalizationRepository())))
        .environmentObject(CoordinatorViewModel())
    }
}
