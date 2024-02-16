//
//  CardView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 7.2.24..
//

import SwiftUI

struct CardView<Content: View>: View {
    private var content: (CGSize) -> Content
    private var cornerSize: CGSize
    
    init(cornerSize: CGSize = CGSize(width: 25.0, height: 25.0), @ViewBuilder content: @escaping (CGSize) -> Content) {
        self.content = content
        self.cornerSize = cornerSize
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: cornerSize)
                .stroke(Color.nmPrimary, lineWidth: 0.5)
                .background{
                    RoundedRectangle(cornerSize: cornerSize)
                        .fill(Color.nmTextBackground)
                        .shadow(color: .nmPrimary, radius: 2.0, y: 3.0)
                }
            
            content(cornerSize)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView { _ in
            Text("Kojekude")
        }
            .padding()
    }
}
