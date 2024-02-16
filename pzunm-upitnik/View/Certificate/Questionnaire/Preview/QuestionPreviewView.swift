//
//  QuestionPreviewView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI

struct QuestionPreviewView: View {
    @State var question: NMQuestion
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(question.formulation)
                        .font(.footnote)
                    Spacer()
                    Text(question.answer.text)
                        .padding(.leading)
                }
                if question.answer == .yes {
                    Text(question.explanation)
                        .font(.footnote)
                        .padding(.horizontal)
                        .frame(minHeight: 1.3)
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
            QuestionPreviewView(question: NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .yes, explanation: "Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira."))
            QuestionPreviewView(question: NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .no, explanation: "Urinirao na vratima javne ustanove."))
                .listRowSeparatorTint(.black)
        }
        .listStyle(.plain)
    }
}
