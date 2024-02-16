//
//  LanguagesView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI

struct LanguagesView: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @State var certificate: NMCertificate
    
    var body: some View {
        ZStack {
            Color.nmBackground
            VStack (alignment: .center) {
                Text(certificate.ime + " " + certificate.prezime)
                    .font(.largeTitle)
                Text(certificate.idString())
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .foregroundColor(.red)
                VStack {
                    ForEach(NMLanguage.allCases, id: \.self) { language in
                        HStack {
                            CardView { _ in
                                Image(language.rawValue + "Flag")
                                    .resizable()
                                    .scaledToFill()
                                    .border(Color.nmPrimary, width: 1.0)
                                    .onTapGesture {
                                        certificate.language = language
                                        coordinatorViewModel.present(with: certificate)
                                    }
                                    .padding(20.0)
                            }
                            .frame(maxWidth: 50.0)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesView(certificate: NMCertificate(id: "001037",
                                         ime: "Nemanja", prezime: "Avramović",
                                         language: nil,
                                         hasCompletedQuestionnaire: false))
        .environmentObject(CoordinatorViewModel())
    }
}
