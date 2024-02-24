//
//  PDFSubmitViewModel.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 23.2.24..
//

import Foundation
import NMModel
import NMServices

class PDFSubmitViewModel: LoadingObject {
    @Published private(set) var state = LoadingState<Void>.idle

    private var pdfService: any PDFServiceProtocol

    init(pdfService: any PDFServiceProtocol) {
        self.pdfService = pdfService
    }

    func reset() {
        state = .idle
    }

    func getPDFPath(for certificateId: String) -> URL {
        URL.documentsDirectory.appending(path: "\(certificateId).pdf")
    }

    func sendPDF(for certificateId: String) {
        Task {
            await MainActor.run {
                state = .loading(0.0)
            }
            let result = await pdfService.uploadPDF(at: getPDFPath(for: certificateId), for: certificateId)
            await MainActor.run {
                switch result {
                case .success:
                    state = .loaded(())
                case .failure(let error):
                    state = .failed(error)
                }
            }
        }
    }
}
