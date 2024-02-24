//
//  QuestionnaireStatusRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 22.2.24..
//

import Foundation
import NMServices

public class QuestionnaireStatusRepository: QuestionnaireStatusRepositoryProtocol {
    private let questionnaireStatuses = "questionnaireStatuses"

    public init() {}

    public func getQuestionnaireStatus(for certificateIds: [Int]) -> [Int: Bool] {
        var newStatuses: [String: Bool] = [:]
        let statuses: [String: Bool] = UserDefaults.standard.object(forKey: questionnaireStatuses) as? [String: Bool] ?? [:]
        for certificateId in (certificateIds.map { "\($0)" }) {
            newStatuses[certificateId] = statuses[certificateId] ?? false
        }
        UserDefaults.standard.set(newStatuses, forKey: questionnaireStatuses)
        return Dictionary(uniqueKeysWithValues: newStatuses.compactMap {
            if let key = Int($0) {
                return (key, $1)
            }
            return nil
        })
    }

    public func setQuestionnaireStatus(for certificateId: Int, to status: Bool) {
        guard let statuses: [Int: Bool] = UserDefaults.standard.object(forKey: questionnaireStatuses) as? [Int: Bool] else {
            return
        }
        let newStatuses = statuses.map { ($0, $0 == certificateId ? status : $1) }
        UserDefaults.standard.set(newStatuses, forKey: questionnaireStatuses)
    }
}
