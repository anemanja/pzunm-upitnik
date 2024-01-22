//
//  ServiceModule.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public class ServiceModule {
    public let authentication: any NMAuthenticationService
    public let clients: any NMClientsService
    public let questions: any NMQuestionsService
    public let pdf: any NMPDFService
    
    init(authentication: NMAuthenticationService, clients: NMClientsService, questions: NMQuestionsService, pdf: NMPDFService) {
        self.authentication = authentication
        self.clients = clients
        self.questions = questions
        self.pdf = pdf
    }
}
