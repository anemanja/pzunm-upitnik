//
//  QuestionsRepository.swift
//  pzunm-upitnik
//
//  Created by Немања Аврамовић on 19.1.24..
//

import Foundation

public final class QuestionsRepository: NMQuestionsRepository {
    public func getQuestions(for language: NMLanguage) async -> Result<NMQuestionnaire, GenericError> {
        .success(NMQuestionnaire(
            language: .srb,
            title: "UPITNIK ZA PODNOSIOCA ZAHTJEVA ZA LJEKARSKO UVJERENJE",
            introduction: "Postovani, ovo je upitnik koji nam pruža uvid u vaše prethodno zdravstveno stanje. Molimo vas da pažljivo pročitate pitanja i iskreno odgovorite zaokruzivanjem tačnog odgovora. Ukoliko je odgovor na pitanje pozitivan, objasnite detaljnije na praznoj liniji ispod odgovora. Vjerodostojnost vašeg odgovora garantujete svojeručnim potpisom.",
            questions: [
                NMQuestion(formulation: "Da li ste imali ili imate neku prirodnu ili stečenu bolest organa vida?", answer: .none),
                NMQuestion(formulation: "Da li ste imali ili imate urođene ili stečene bolesti organa sluha ili ravnoteže?", answer: .none),
                NMQuestion(formulation: "Da li bolujete od neke duševne bolesti?", answer: .none),
                NMQuestion(formulation: "Da li ste bolovali ili bolujete od neke bolesti zavisnosti (alkoholizam, toksikomanija, zloupotreba psihotropnih supstanci)?", answer: .none)
            ]))
    }
}

public final class ClientsRepository: NMClientsRepository {
    public func getClients() async -> Result<[NMClient], GenericError> {
        return .success([
            NMClient(id: "0012301", name: "Murat", surname: "Osmanoglu",
                     language: .tur, hasCompletedQuestionnaire: false),
            NMClient(id: "0233540", name: "Berat", surname: "Krasnichi",
                     language: .alb, hasCompletedQuestionnaire: true),
            NMClient(id: "0003153", name: "Radovan", surname: "Berović",
                     language: .srb, hasCompletedQuestionnaire: false),
            NMClient(id: "1125003", name: "Osman", surname: "Jagluk",
                     language: .tur, hasCompletedQuestionnaire: true),
            NMClient(id: "0002318", name: "Vukomir", surname: "Avramović",
                     language: .srb, hasCompletedQuestionnaire: false)
        ])
    }
}

public final class AuthenticationRepository: NMAuthenticationRepository {
    public func authenticateUser(with username: String, and password: String) async -> Result<Void, GenericError> {
        if username == "ricko" && password == "vukomir" {
            return .success(())
        }
        
        if username == "jelena" && password == "nemanja" {
            return .success(())
        }
        
        return .failure(GenericError.customError(message: "Wrong Credentials."))
    }
}

public final class PDFRepository: NMPDFRepository {
    public func uploadPDF(at path: URL, for clientId: String) async -> Result<Void, GenericError> {
        .success(())
    }
}

public class MockRepositoryModule {
    public let authentication: any NMAuthenticationRepository = AuthenticationRepository()
    public let clients: any NMClientsRepository = ClientsRepository()
    public let questions: any NMQuestionsRepository = QuestionsRepository()
    public let pdf: any NMPDFRepository = PDFRepository()
}
