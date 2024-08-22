//
//  Model.swift
//  RangTech
//
//  Created by Rahul Bashetty on 18/08/24.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
}

struct ErrorResponse: Codable {
    let error: String
}

struct Inspection: Identifiable, Hashable {
    let id: Int
    let inspectionType: InspectionType
    let area: Area
    let survey: Survey
}

struct InspectionType: Hashable {
    let id: Int
    let name: String
    let access: String
}

struct Area: Hashable {
    let id: Int
    let name: String
}

struct Survey: Hashable {
    let id: Int
    let categories: [Category]
}

struct Category: Hashable {
    let id: Int
    let name: String
    let questions: [Question]
}

struct Question: Hashable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoice]
    let selectedAnswerChoiceId: Int?
}

struct AnswerChoice: Hashable {
    let id: Int
    let name: String
    let score: Double
}
