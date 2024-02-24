//
//  QuestionnaireButton.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 1.2.24..
//

import SwiftUI

extension Image {
    func questionnaireButtonModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}

extension View {
    func conditionalShadow(enabled: Bool,
                           color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
                           radius: CGFloat,
                           x: CGFloat = 0.0, y: CGFloat = 0.0) -> some View {
        if enabled {
            return self
                .shadow(color: color, radius: radius, x: x, y: y)
        } else {
            return self
                .shadow(radius: 0.0)
        }
    }
}
