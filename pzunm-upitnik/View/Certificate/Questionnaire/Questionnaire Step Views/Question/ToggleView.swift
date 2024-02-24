//
//  ToggleView.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 2.2.24..
//

import SwiftUI

struct ToggleView: View {
    @Binding var isOn: Bool
    @State var enabled: Bool
    @State var text: String = ""
    @State var imageSystemName: String = "circle"
    @State var primaryColor: Color = .nmTitle
    @State var secondaryColor: Color = .primary
    @State var shadowColor: Color = .init(white: 0.0, opacity: 0.333)
    @State var fontSize: CGFloat = 31.7
    @State var textColor: Color = .primary
    @State var backgroundColor: Color = .secondary
    
    var onTapGesture: () -> Void
    
    var body: some View {
        ZStack {
            Image(systemName: imageSystemName + (!isOn ? ".fill" : ""))
                .questionnaireButtonModifier()
                .foregroundColor(isOn ? secondaryColor : primaryColor)
                .onTapGesture {
                    if enabled {
                        isOn.toggle()
                        onTapGesture()
                    }
                }
                .conditionalShadow(enabled: !isOn, color: shadowColor, radius: 3.0, y: 2.0)
            Text(text)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundColor(isOn ? textColor : backgroundColor)
                .allowsHitTesting(false)
        }
    }
}

struct ToggleView_Previews: PreviewProvider {
    @State static var ison = false
    static var previews: some View {
        ToggleView(isOn: $ison, enabled: true) {}
    }
}
