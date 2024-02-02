//
//  NMClientListView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.1.24..
//

import SwiftUI

struct NMClientListItemView: View {
    @State var client: NMClient
    @State var shouldShowAll: Bool
    
    var body: some View {
        ZStack {
            if shouldShowAll {
                Color(client.hasCompletedQuestionnaire ? .init(red: 0.9, green: 1.0, blue: 0.7, alpha: 1.0) : .clear)
                    .frame(minWidth: 50.0, alignment: .center)
            }
            HStack(alignment: .center) {
                Text(client.id)
                    .foregroundColor(.red)
                    .frame(minWidth: 100.0, alignment: .trailing)
                Text(client.surname)
                Text(client.name)
                Spacer()
                if shouldShowAll {
                    if client.hasCompletedQuestionnaire {
                        Image(systemName: "checkmark.square.fill")
                    } else {
                        Image(systemName: "square")
                    }
                }
            }
        }
    }
}
