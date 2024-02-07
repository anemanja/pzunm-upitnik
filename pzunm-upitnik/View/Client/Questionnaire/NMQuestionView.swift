//
//  NMQuestionView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import SwiftUI

struct NMQuestionView: View {
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
        NMCardView {
            
            RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0))
                .stroke(NMPalette.foreground.color, lineWidth: 0.5)
                .background(RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0)).fill(Color(NMPalette.background.rawValue)))
                .shadow(color: NMPalette.foreground.color, radius: 2.0, y: 3.0)
            
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
                               secondaryColor: .blue, textColor: NMPalette.text.color, backgroundColor: NMPalette.background.color) {
                        isNoSelected = false
                        answer = .yes
                    }
                    
                    Spacer()
                    
                    ToggleView(isOn: $isNoSelected, enabled: true,
                               text: noLabelText,
                               secondaryColor: .blue, textColor: NMPalette.text.color, backgroundColor: NMPalette.background.color) {
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
                        onAllowedToContinue()
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



struct NMQuestionView_Previews: PreviewProvider {
    
    @State static var answer = NMAnswer.none
    @State static var explanation = ""
    
    static var previews: some View {
        VStack {
            NMSectionHeaderView(text: "Pitanja")
                .foregroundColor(NMPalette.foreground.color)
            NMQuestionView(answer: $answer,
                           explanation: $explanation,
                           index: 12,
                           question: "Da li ste bolovali ili bolujete od neke bolesti zavisnosti (alkoholizam, toksikomanija, zloupotreba psihotropnih supstanci)?",
                           onAllowedToContinue: {})
//            .offset(x: 50.0, y: -70.0)
//            .rotationEffect(Angle(degrees: 10.0))
            Spacer()
        }
        .padding(50.0)
        .background(Color(NMPalette.light.rawValue))
    }
}
