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
            HStack(alignment: .center) {
                Text(client.id)
                    .foregroundColor(.accentColor)
                    .fontDesign(.monospaced)
                    .frame(minWidth: 70.0, alignment: .trailing)
                Text(client.surname + " " + client.name)
                    .padding(.horizontal)
                if shouldShowAll && client.hasCompletedQuestionnaire {
                    Color(NMPalette.foreground.rawValue)
                        .frame(maxHeight: 7.0)
                        .cornerRadius(3.5)
                } else {
                    Spacer()
                }
                if shouldShowAll {
                    Image(systemName: client.hasCompletedQuestionnaire ? "checkmark.square.fill" : "square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 17.3)
                        .foregroundColor(NMPalette.foreground.color)
                }
            }
        }
    }
}

struct NMClientListItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NMClientListItemView(client: NMClient(id: "009113", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: true), shouldShowAll: true)
            NMClientListItemView(client: NMClient(id: "009003", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: false), shouldShowAll: true)
            NMClientListItemView(client: NMClient(id: "012003", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: true), shouldShowAll: false)
            NMClientListItemView(client: NMClient(id: "007103", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: false), shouldShowAll: false)
        }
    }
}
