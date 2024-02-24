//
//  QuestionnaireSubmitView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 17.2.24..
//

import SwiftUI

@MainActor
struct PDFSubmitView<Content: View>: View {
    @EnvironmentObject var coordinatorViewModel: CoordinatorViewModel
    @ObservedObject var viewModel: PDFSubmitViewModel
    
    private var content: () -> Content
    private var submitLabel: String
    private var cancelLabel: String
    private var certificateId: String

    init(viewModel: PDFSubmitViewModel, submitLabel: String, cancelLabel: String, certificateId: String, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
        self.submitLabel = submitLabel
        self.cancelLabel = cancelLabel
        self.certificateId = certificateId
    }

    var body: some View {
        LoadingView(source: viewModel) {
            VStack {
                content()
                    .padding()
                    .border(Color.nmPrimary)

                HStack {
                    Button(cancelLabel) {
                        cancel()
                    }
                    .buttonStyle(.bordered)
                    .accentColor(.nmTitle)
                    .padding()

                    Button(submitLabel) {
                        submit()
                    }
                    .buttonStyle(.borderedProminent)
                    .accentColor(.nmTitle)
                    .padding()
                    .disabled(true)

                    ShareLink(item: renderPDF()) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.borderless)
                    .accentColor(.nmTitle)
                    .padding(.trailing, 20.0)
                }
            }
            .padding(.vertical)
        } loader: { _ in
            NMProgressView()
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
        renderPDF()
        viewModel.sendPDF(for: certificateId)
    }

    func cancel() {
        coordinatorViewModel.dismissCover()
    }

    @discardableResult
    func renderPDF() -> URL {
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

        return url
    }
}
