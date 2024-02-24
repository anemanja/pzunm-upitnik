//
//  QuestionnaireSubmitView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.2.24..
//

import SwiftUI

@MainActor
struct PDFSubmitView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PDFSubmitViewModel
    
    private var content: () -> Content
    private var submitLabel: String
    private var certificateId: String

    init(viewModel: PDFSubmitViewModel, submitLabel: String, certificateId: String, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
        self.submitLabel = submitLabel
        self.certificateId = certificateId
    }

    var body: some View {
        LoadingView(source: viewModel) {
            VStack {
                content()
                    .border(.black)
                Button(submitLabel) {
                    submit()
                }
                //            ShareLink(submitLabel, item: submit())
                //                .buttonStyle(.borderedProminent)
                //                .accentColor(.nmTitle)
                //                .padding()
            }
            .padding(.vertical)
        } loader: { _ in
            ProgressView()
                .foregroundColor(.nmPrimary)
        } error: { error in
            ErrorView(error) {
                viewModel.reset()
            }
        } content: { _ in
            CardView { _ in
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.nmPrimary)
                    .frame(width: 100.0)
            }
            .frame(width: 200.0)
        }
    }

    func submit() {
        let renderer = ImageRenderer(content: content())
        let url = viewModel.getPDFPath(for: certificateId)

        renderer.render { _, context in
            var box = CGRect(x: 0, y: 0, width: 597.6, height: 842.4)
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }

        viewModel.sendPDF(for: certificateId)
    }
}
