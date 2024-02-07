//
//  NMSectionHeaderView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 2.2.24..
//

import SwiftUI

struct NMSectionHeaderView: View {
    @State var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.headline.lowercaseSmallCaps())
            Spacer()
        }
    }
}

struct NMSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NMSectionHeaderView(text: "Section Header")
            .foregroundColor(NMPalette.foreground.color)
    }
}
