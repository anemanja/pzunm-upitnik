//
//  SectionHeaderView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 2.2.24..
//

import SwiftUI

struct SectionHeaderView: View {
    @State private var text: String

    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline.lowercaseSmallCaps())
            Spacer()
        }
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(text: "Section Header")
            .foregroundColor(.nmPrimary)
    }
}
