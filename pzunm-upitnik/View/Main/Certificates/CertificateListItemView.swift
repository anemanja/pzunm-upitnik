//
//  NMCertificateListView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.1.24..
//

import SwiftUI
import NMModel

struct CertificateListItemView: View {
    @State private var certificate: NMCertificate
    @State private var shouldShowAll: Bool

    init(certificate: NMCertificate, shouldShowAll: Bool) {
        self.certificate = certificate
        self.shouldShowAll = shouldShowAll
    }

    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Text(certificate.idString())
                    .foregroundColor(.nmTitle)
                    .font(.title)
                    .fontDesign(.monospaced)
                    .frame(minWidth: 70.0, alignment: .trailing)
                Text(certificate.surname + " " + certificate.name)
                    .font(.title)
                    .padding(.horizontal)

                Spacer()
            }
            .frame(minHeight: 50.0)
        }
    }
}

struct NMCertificateListItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CertificateListItemView(certificate: NMCertificate(id: "009113", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: true), shouldShowAll: true)
            CertificateListItemView(certificate: NMCertificate(id: "009003", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: false), shouldShowAll: true)
            CertificateListItemView(certificate: NMCertificate(id: "012003", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: true), shouldShowAll: false)
            CertificateListItemView(certificate: NMCertificate(id: "007103", name: "Vukomir", surname: "Avramović", hasCompletedQuestionnaire: false), shouldShowAll: false)
        }
    }
}
