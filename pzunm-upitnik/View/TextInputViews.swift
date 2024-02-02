//
//  SecureInputView.swift
//  Yarnboard
//
//  Created by Nemanja on 5.5.23..
//

import SwiftUI

struct TextInputView: View {
    @Binding private var text: String
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        VStack {
            TextField(title, text: $text)
                .padding(.top, 12.0)
                .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            Divider()
        }
        .padding(.horizontal, 36.0)
    }
}

struct LargeTextInputView: View {
    @Binding private var text: String
    private var title: String
    private var minLineCount: Int
    private var maxLineCount: Int
    
    init(_ title: String, text: Binding<String>, minLineCount: Int = 1, maxLineCount: Int = 4) {
        self.title = title
        self.minLineCount = minLineCount
        self.maxLineCount = maxLineCount
        self._text = text
    }
    
    var body: some View {
        TextField(title, text: $text, axis: .vertical)
            .textFieldStyle(.roundedBorder)
            .lineLimit(minLineCount...maxLineCount)
            .padding(.top, 12.0)
            .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
            .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 36.0)
    }
}

struct SecureInputView: View {
    @State private var isSecured: Bool = true
    @Binding private var text: String
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack {
                Group {
                    if isSecured {
                        SecureField(title, text: $text)
                    } else {
                        TextField(title, text: $text)
                    }
                }
                .padding(.trailing, 32)
                .padding(.top, 12.0)
                .textInputAutocapitalization(/*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Divider()
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(YarnboardPalette.textSecondary.color)
            }
        }
        .padding(.horizontal, 36.0)
    }
}
