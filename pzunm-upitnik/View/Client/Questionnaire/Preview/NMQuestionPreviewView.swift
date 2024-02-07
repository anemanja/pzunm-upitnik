//
//  NMQuestionPreviewView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import SwiftUI

struct NMQuestionPreviewView: View {
    @State var question: NMQuestion
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(question.formulation)
                    Spacer()
                    Text(question.answer.text)
                        .padding(.leading)
                }
                if question.answer == .yes {
                    Text(question.explanation)
                        .padding(.horizontal)
                        .frame(minHeight: 1.3)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct NMQuestionPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NMQuestionPreviewView(question: NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .yes, explanation: "Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira. Narusavanje javnog reda i mira."))
            NMQuestionPreviewView(question: NMQuestion(formulation: "Da li ste nekada bili skloni neprilagodjenom ponašanju (dolazili u sukob sa zakonom ili ispoljili izrazitu socijalnu i emocionalnu nestabilnost)?", answer: .no, explanation: "Urinirao na vratima javne ustanove."))
                .listRowSeparatorTint(.black)
        }
        .listStyle(.plain)
    }
}
