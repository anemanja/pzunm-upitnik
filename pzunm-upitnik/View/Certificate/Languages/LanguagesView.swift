//
//  LanguagesView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import SwiftUI
import NMModel

struct LanguagesView: View {
    @EnvironmentObject private var coordinatorViewModel: CoordinatorViewModel
    @State private var certificate: NMCertificate

    init(certificate: NMCertificate) {
        self.certificate = certificate
    }
    
    var body: some View {
        ZStack {
            Color.nmBackground
            VStack (alignment: .center) {
                Text(certificate.name + " " + certificate.surname)
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
                                        print(String(describing: language))
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
