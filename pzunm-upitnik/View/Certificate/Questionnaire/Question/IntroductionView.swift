//
//  IntroductionView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 23.2.24..
//

import SwiftUI

struct IntroductionView: View {
    private let introduction: String
    private let confirm: String
    private let nextAction: () -> Void
    private let skipAction: () -> Void

    init(introduction: String, confirm: String, nextAction: @escaping () -> Void, skipAction: @escaping () -> Void) {
        self.introduction = introduction
        self.confirm = confirm
        self.nextAction = nextAction
        self.skipAction = skipAction
    }

    var body: some View {
        VStack {
            CardView { _ in
                Text(introduction)
                    .font(.title)
                    .padding(.horizontal, 50.0)
                    .foregroundColor(.nmTitle)
                    .multilineTextAlignment(.center)
            }

            ZStack {
                Button(confirm) {
                    nextAction()
                }
                .buttonStyle(.borderedProminent)
                .accentColor(.nmTitle)

                HStack {
                    Spacer()

                    Button(action: skipAction, label: {
                        Image(systemName: "arrow.right.to.line.compact")
                    })
                    .buttonStyle(.borderless)
                    .accentColor(.nmTitle)
                    .padding(.trailing, 20.0)
                }
            }
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView(introduction: "Introduction", confirm: "Važi se", nextAction: {}, skipAction: {})
    }
}
