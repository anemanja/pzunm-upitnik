//
//  NMQuestionnaireView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 18.1.24..
//

import SwiftUI
import PencilKit

struct NMQuestionnaireView: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @EnvironmentObject var viewModel: NMQuestionnaireViewModel
    
    @State var client: NMClient
    @State var canvasView = PKCanvasView()
    @State var shouldDisableScrolling = false
    @State var shouldShowButtons = false
    @State var offsetIteration: CGFloat = 0.0
    @State var currentExplanation = ""

    var body: some View {
        VStack {
            
            Text (viewModel.questionnaire.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
            
            GeometryReader { gp in
                HStack (alignment: .top, spacing: 0) {
                    
                    VStack {
                        NMCardView {
                            Text(viewModel.questionnaire.introduction)
                                .font(.title)
                                .padding(.horizontal, 50.0)
                                .foregroundColor(.accentColor)
                                .multilineTextAlignment(.center)
                        }
                        
                        Button("Potvrdi") {
//                            withAnimation(.easeOut) {
                                nextQuestion()
//                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .frame(width: gp.size.width)
                    
                    ForEach($viewModel.questionnaire.questions, id: \.hashValue) { $question in
                        NMQuestionView(answer: $question.answer,
                                       explanation: $currentExplanation,
                                       index: question.id,
                                       question: question.formulation,
                                       onAllowedToContinue: nextQuestion)
                        .padding()
                        .frame(width: gp.size.width)
                    }
                    
                    ZStack (alignment: .top) {
                        NMCardView {
                            VStack{
                                NMSectionHeaderView(text: "Svojeručni potpis")
                                    .foregroundColor(NMPalette.foreground.color)
                                CanvasView(canvasView: $canvasView, onSaved: onSaved, onBegan: onBegan, onEnded: onEnded)
                                    .border(Color(NMPalette.light.rawValue))
                                Text(client.name + " " + client.surname)
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
                                    Button("Obriši potpis", action: deleteDrawing)
                                        .buttonStyle(.bordered)
                                    Button("Završi", action: done)
                                        .buttonStyle(.borderedProminent)
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
            
            HStack {
                ForEach(viewModel.currentQuestionIndicators.indices, id: \.hashValue) { index in
                    ToggleView(isOn: $viewModel.currentQuestionIndicators[index],
                               enabled: false,
                               text: "\(index + 1)", imageSystemName: "rectangle",
                               primaryColor: NMPalette.foreground.color,
                               secondaryColor: NMPalette.foreground.color,
                               shadowColor: .clear,
                               fontSize: 20.0,
                               textColor: NMPalette.foreground.color,
                               backgroundColor: NMPalette.background.color) {}
                }
            }
            .frame(height: 30.0)
            
            Spacer()
        }
        .padding(37.1)
        .background(NMPalette.light.color)
        .onAppear {
            viewModel.fillQuestionnaire(for: .srb)
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
        coordinatorViewModel.cover(with: NMQuestionnairePreview(clientId: client.id, questionnaire: viewModel.questionnaire, signatureView: Image(uiImage: canvasView.drawing.image(from: canvasView.bounds, scale: 1.0))))
    }
}

struct NMQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        NMQuestionnaireView(client: NMClient(id: "001037",
                                         name: "Nemanja", surname: "Avramović",
                                         language: nil,
                                         hasCompletedQuestionnaire: false))
        .environmentObject(NMQuestionnaireViewModel(questionsService: NMQuestionsServiceMock(repository: MockRepositoryModule().questions), pdfService: NMPDFServiceImplementation(repository: MockRepositoryModule().pdf)))
        .environmentObject(CoordinatorViewModel())
        
    }
}
