//
//  QuestionPreviewView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI

struct QuestionPreviewView: View {
    @State var question: NMQuestion
    @State var yesLabel: String
    @State var noLabel: String
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text("\(question.index).\t" + question.formulation)
                        .font(.system(size: 10.0, design: .serif))
                    Spacer()
                    HStack {
                        QuestionPreviewButton(buttonLabel: yesLabel, isCircled: question.answer == .yes)
                        QuestionPreviewButton(buttonLabel: noLabel, isCircled: question.answer == .no)
                    }
                }
                if question.answer == .yes {
                    Text(question.explanation)
                        .font(.system(size: 9.0, design: .serif))
                        .padding(.horizontal)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct QuestionPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            QuestionPreviewView(question: NMQuestion(index: 1, formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .yes, explanation: "Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira."), yesLabel: "DA", noLabel: "NE")
            QuestionPreviewView(question: NMQuestion(index: 2, formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .no, explanation: "Urinirao na vratima javne ustanove."), yesLabel: "DA", noLabel: "NE")
                .listRowSeparatorTint(.black)
        }
        .listStyle(.plain)
    }
}
