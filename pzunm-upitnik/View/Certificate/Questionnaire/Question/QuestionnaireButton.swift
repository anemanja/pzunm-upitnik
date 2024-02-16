//
//  QuestionnaireButton.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 1.2.24..
//

import SwiftUI

struct QuestionnaireButton: View {
    @State var isSelected = false
    var systemName: String
    @State var answerSelection: Bool
    @Binding var answer: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "\(systemName).circle" + (isSelected ? ".fill" : ""))
                .questionnaireButtonModifier()
                .onTapGesture {
                    isSelected.toggle()
                    answer = (answerSelection == isSelected)
                }
        }
    }
}

struct QuestionnaireButton_Previews: PreviewProvider {
    @State static var isSelected = true
    static var previews: some View {
        QuestionnaireButton(systemName: "checkmark", answerSelection: true, answer: $isSelected)
    }
}

extension Image {
    func questionnaireButtonModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}

extension View {
    func conditionalShadow(enabled: Bool,
                           color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
                           radius: CGFloat,
                           x: CGFloat = 0.0, y: CGFloat = 0.0) -> some View {
        if enabled {
            return self
                .shadow(color: color, radius: radius, x: x, y: y)
        } else {
            return self
                .shadow(radius: 0.0)
        }
    }
}
