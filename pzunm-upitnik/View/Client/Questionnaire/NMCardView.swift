//
//  NMCardView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 7.2.24..
//

import SwiftUI

struct NMCardView<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0))
                .stroke(NMPalette.foreground.color, lineWidth: 0.5)
                .background{
                    RoundedRectangle(cornerSize: CGSize(width: 25.0, height: 25.0))
                        .fill(Color(NMPalette.background.rawValue))
                        .shadow(color: NMPalette.foreground.color, radius: 2.0, y: 3.0)
                }
            
            content()
        }
    }
}

struct NMCardView_Previews: PreviewProvider {
    static var previews: some View {
        NMCardView {
            Text("Kojekude")
        }
            .padding()
    }
}
