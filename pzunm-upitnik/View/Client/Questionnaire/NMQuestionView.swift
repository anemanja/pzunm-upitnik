//
//  NMQuestionView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.1.24..
//

import SwiftUI

struct NMQuestionView: View {
    @Binding var question: NMQuestion
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(question.formulation, isOn: $question.answer)
                .toggleStyle(SwitchToggleStyle(tint: .red))
            if question.answer {
                TextField("Explanation here.",
                          text: $question.explanation,
                          axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
        }
        .padding()
    }
}

