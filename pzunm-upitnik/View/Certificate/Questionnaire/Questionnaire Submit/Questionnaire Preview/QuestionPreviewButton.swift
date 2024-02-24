//
//  QuestionPreviewButton.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.2.24..
//

import SwiftUI

struct QuestionPreviewButton: View {
    @State var buttonLabel: String
    @State var isCircled: Bool

    var body: some View {
        ZStack {
            if isCircled {
                Image(systemName: "circle")
                    .questionnaireButtonModifier()
                    .frame(width: 20.0)
                    .foregroundColor(.blue)
            }
            Text(buttonLabel)
                .font(.system(size: 10.0, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.nmPrimaryText)
                .shadow(color: .white, radius: 1.0)
                .shadow(color: .white, radius: 1.0)
                .shadow(color: .white, radius: 1.0)
        }
    }
}

struct QuestionPreviewButton_Previews: PreviewProvider {
    static var previews: some View {
        QuestionPreviewButton(buttonLabel: "NAYIR", isCircled: true)
    }
}
