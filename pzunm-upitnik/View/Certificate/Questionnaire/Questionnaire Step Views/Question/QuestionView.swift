//
//  QuestionView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import SwiftUI
import NMModel

struct QuestionView: View {
    @State private var explanation = ""
    @State private var answer: NMAnswer = .none
    @State private var isYesSelected = false
    @State private var isNoSelected = false
    @State private var isEnabled = true
    @FocusState private var isFocused: Bool

    private var index: Int
    private var question: String
    private var yesLabelText = "DA"
    private var noLabelText = "NE"
    private var explanationPlaceholderText = "Objašnjenje..."
    
    private var onAllowedToContinue: (Bool, String) -> Void

    init(explanation: String = "", answer: NMAnswer = .none, index: Int, question: String, yesLabelText: String = "DA", noLabelText: String = "NE", explanationPlaceholderText: String = "Objašnjenje...", isYesSelected: Bool = false, isNoSelected: Bool = false, isEnabled: Bool = true, onAllowedToContinue: @escaping (Bool, String) -> Void) {
        self.explanation = explanation
        self.answer = answer
        self.index = index
        self.question = question
        self.yesLabelText = yesLabelText
        self.noLabelText = noLabelText
        self.explanationPlaceholderText = explanationPlaceholderText
        self.isYesSelected = isYesSelected
        self.isNoSelected = isNoSelected
        self.isEnabled = isEnabled
        self.onAllowedToContinue = onAllowedToContinue
    }
    
    var body: some View {
        CardView { _ in
            
            RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0))
                .stroke(Color.nmPrimary, lineWidth: 0.5)
                .background(RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0)).fill(Color.nmTextBackground))
                .shadow(color: .nmPrimary, radius: 2.0, y: 3.0)
            
            VStack(alignment: .leading) {
                
                HStack (alignment: .top) {
                    Text("\(index).")
                        .font(.system(size: 24.0))
                        .padding()
                    Text(question)
                        .font(.system(size: 24.0))
                        .padding()
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
                
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    ToggleView(isOn: $isYesSelected, enabled: true,
                               text: yesLabelText,
                               secondaryColor: .blue, textColor: .nmPrimaryText,
                               backgroundColor: .nmTextBackground) {
                        isNoSelected = false
                        isFocused = true
                        answer = .yes
                    }
                    
                    Spacer()
                    
                    ToggleView(isOn: $isNoSelected, enabled: true,
                               text: noLabelText,
                               secondaryColor: .blue, textColor: .nmPrimaryText,
                               backgroundColor: .nmTextBackground) {
                        if isEnabled {
                            isYesSelected = false
                            answer = .no
                            isFocused = false
                            isEnabled = false
                            onAllowedToContinue(false, "")
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxHeight: 73.0)
                .padding(.top, 169.0)
                
                Spacer()
                
                if isYesSelected {
                    LargeTextInputView(explanationPlaceholderText, text: $explanation, minLineCount: 2, maxLineCount: 2) {
                        if !explanation.isEmpty && isEnabled {
                            onAllowedToContinue(true, explanation)
                            isFocused = false
                            isEnabled = false
                        }
                    }
                        .font(.title2)
                        .padding()
                        .focused($isFocused)
                }
            }
            .padding()
        }
        .frame(height: 371.0 + (isYesSelected ? 73.1 : 0.0))
        .onAppear {
            isYesSelected = answer == .yes
            isNoSelected = answer == .no
        }
    }
}
