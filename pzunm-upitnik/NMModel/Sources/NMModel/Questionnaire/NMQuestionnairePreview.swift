//
//  NMQuestionnairePreview.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 25.1.24..
//

import Foundation
import SwiftUI

public struct NMQuestionnairePreview {
    public let certificateId: String
    public let title: String
    public let introduction: String
    public let questions: [NMQuestion]
    public let yesLabel: String
    public let noLabel: String
    public let submitLabel: String
    public let cancelLabel: String
    public let signatureView: Image
}

extension NMLocalization {
    public func preview(for certificateId: String, with questions: [NMQuestion], and signatureView: Image) -> NMQuestionnairePreview {
        NMQuestionnairePreview(certificateId: certificateId,
                               title: title,
                               introduction: introduction,
                               questions: questions,
                               yesLabel: yes,
                               noLabel: no,
                               submitLabel: submit, cancelLabel: cancel,
                               signatureView: signatureView)
    }
}
