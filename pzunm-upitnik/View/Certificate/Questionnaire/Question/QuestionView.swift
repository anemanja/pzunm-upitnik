//
//  QuestionView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import SwiftUI

struct QuestionView: View {
    @Binding var answer: NMAnswer
    @Binding var explanation: String
    
    @State var index: Int
    @State var question: String
    @State var yesLabelText = "DA"
    @State var noLabelText = "NE"
    @State var explanationPlaceholderText = "Objašnjenje..."
    @State var isYesSelected = false
    @State var isNoSelected = false
    
    var onAllowedToContinue: () -> Void
    
    var body: some View {
        CardView { _ in
            
            RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0))
                .stroke(Color.nmPrimary, lineWidth: 0.5)
                .background(RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0)).fill(Color.nmTextBackground))
                .shadow(color: .nmPrimary, radius: 2.0, y: 3.0)
            
            VStack(alignment: .leading) {
                
                HStack (alignment: .top) {
                    Text("\(index).")
                        .font(.title)
                        .padding()
                    Text(question)
                        .font(.title)
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
                        answer = .yes
                    }
                    
                    Spacer()
                    
                    ToggleView(isOn: $isNoSelected, enabled: true,
                               text: noLabelText,
                               secondaryColor: .blue, textColor: .nmPrimaryText,
                               backgroundColor: .nmTextBackground) {
                        isYesSelected = false
                        answer = .no
                        onAllowedToContinue()
                    }
                    
                    Spacer()
                }
                .frame(maxHeight: 100.0)
                .padding(.top, 169.0)
                
                Spacer()
                
                if isYesSelected {
                    LargeTextInputView(explanationPlaceholderText, text: $explanation, minLineCount: 3) {
                        if !explanation.isEmpty {
                            onAllowedToContinue()
                        }
                    }
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding()
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



struct QuestionView_Previews: PreviewProvider {
    
    @State static var answer = NMAnswer.none
    @State static var explanation = ""
    
    static var previews: some View {
        VStack {
            QuestionView(answer: $answer,
                           explanation: $explanation,
                           index: 12,
                           question: "Da li ste bolovali ili bolujete od neke bolesti zavisnosti (alkoholizam, toksikomanija, zloupotreba psihotropnih supstanci)?",
                           onAllowedToContinue: {})
//            .offset(x: 50.0, y: -70.0)
//            .rotationEffect(Angle(degrees: 10.0))
            Spacer()
        }
        .padding(50.0)
        .background(Color.nmBackground)
    }
}
