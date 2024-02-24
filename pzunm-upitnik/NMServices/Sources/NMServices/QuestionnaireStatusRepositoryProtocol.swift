//
//  QuestionnaireStatusRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.2.24..
//

import Foundation

public protocol QuestionnaireStatusRepositoryProtocol {
    func getQuestionnaireStatus(for certificateIds: [Int]) -> Dictionary<Int, Bool>
    func setQuestionnaireStatus(for certificateId: Int, to status: Bool)
}
