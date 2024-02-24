//
//  SignatureView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 23.2.24..
//

import SwiftUI
import PencilKit

struct SignatureView: View {
    @State private var canvasView = PKCanvasView()
    @State private var shouldShowButtons = false

    private let signature: String
    private let name: String
    private let surname: String
    private let eraseSignature: String
    private let confirm: String
    private let done: (Image) -> Void

    init(signature: String, name: String, surname: String, eraseSignature: String, confirm: String, done: @escaping (Image) -> Void) {
        self.signature = signature
        self.name = name
        self.surname = surname
        self.eraseSignature = eraseSignature
        self.confirm = confirm
        self.done = done
    }

    var body: some View {
        ZStack (alignment: .top) {
            CardView { _ in
                VStack{
                    SectionHeaderView(text: signature)
                        .foregroundColor(.nmPrimary)
                    CanvasView(canvasView: $canvasView, onSaved: onSaved)
                        .border(Color.nmBackground)
                    Text(name + " " + surname)
                        .font(.title2)
                        .padding()
                }
                .padding()
            }
            .padding(.bottom, 50.0)
            .frame(maxHeight: 300.0)

            VStack {
                Spacer()

                HStack {
                    if shouldShowButtons {
                        Button(eraseSignature, action: deleteDrawing)
                            .buttonStyle(.bordered)
                            .accentColor(.nmTitle)
                        Button(confirm) {
                            done(Image(uiImage: canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)))
                        }
                            .buttonStyle(.borderedProminent)
                            .accentColor(.nmTitle)
                    }
                }
            }
        }
    }

    func onSaved() {
        shouldShowButtons = true
    }

    func deleteDrawing() {
        shouldShowButtons = false
        canvasView.drawing = PKDrawing()
    }
}

struct SignatureView_Previews: PreviewProvider {
    static var previews: some View {
        SignatureView(signature: "Potpis", name: "Nemanja", surname: "Vukosavljević", eraseSignature: "Obriši", confirm: "Važili", done: { _ in })
    }
}
