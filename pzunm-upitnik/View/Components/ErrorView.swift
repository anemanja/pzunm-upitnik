//
//  ErrorView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 23.2.24..
//

import SwiftUI
import NMServices

struct ErrorView: View {
    private var error: GenericError
    private var onClose: () -> Void

    init(_ error: GenericError, onClose: @escaping () -> Void) {
        self.error = error
        self.onClose = onClose
    }

    var body: some View {
        CardView() { _ in
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 30.0)
                        Text(error.title)
                            .font(.title)
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: 300.0)
                            .padding()
                    }
                    Text(error.description)
                        .fontDesign(.monospaced)
                }
                .foregroundColor(.nmError)

                VStack {
                    HStack {
                        Spacer ()

                        Button(action: onClose) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30.0)
                                .foregroundColor(.nmTitle)
                        }
                        .padding()
                    }

                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.nmBackground)
    }
}
