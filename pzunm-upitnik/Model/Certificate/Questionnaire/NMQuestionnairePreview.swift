//
//  NMQuestionnairePreview.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import Foundation
import SwiftUI

struct NMQuestionnairePreview {
    let certificateId: String
    let title: String
    let introduction: String
    let questions: [NMQuestion]
    let yesLabel: String
    let noLabel: String
    let submitLabel: String
    let signatureView: Image
}

extension NMLocalization {
    func preview(for certificateId: String, with questions: [NMQuestion], and signatureView: Image) -> NMQuestionnairePreview {
        NMQuestionnairePreview(certificateId: certificateId,
                               title: title,
                               introduction: introduction,
                               questions: questions,
                               yesLabel: yes,
                               noLabel: no,
                               submitLabel: submit,
                               signatureView: signatureView)
    }
}
