//
//  NMLanguagesView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct NMLanguagesView: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @State var client: NMClient
    
    var body: some View {
        VStack {
            Text(client.name + " " + client.surname)
            Text(client.id)
                .foregroundColor(.red)
            List {
                ForEach(NMLanguage.allCases, id: \.self) { language in
                    HStack {
                        Text(language.rawValue)
                        Spacer()
                    }
                    .onTapGesture {
                        client.language = language
                        coordinatorViewModel.present(with: client)
                    }
                }
            }
        }
    }
}

struct NMLanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        NMLanguagesView(client: NMClient(id: "001037",
                                         name: "Nemanja", surname: "Avramović",
                                         language: nil,
                                         hasCompletedQuestionnaire: false))
        .environmentObject(CoordinatorViewModel())
    }
}
