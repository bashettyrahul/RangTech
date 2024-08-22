//
//  LoginView.swift
//  RangTech
//
//  Created by Rahul Bashetty on 18/08/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showInspectionView = false
    @State private var inspection: Inspection?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Continue") {
                    let user = User(email: email, password: password)
                    AuthService.shared.login(user: user) { result in
                        switch result {
                        case .success:
                            
                            fetchInspectionData()
                        case .failure(let error):
                            print("Login failed: \(error.localizedDescription)")
                        }
                    }
                }
                .padding()

                if let inspection = inspection {
                    NavigationLink(destination: InspectionView(inspection: inspection), isActive: $showInspectionView) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Login")
        }
    }

    private func fetchInspectionData() {
        
        let sampleInspection = Inspection(
            id: 1,
            inspectionType: InspectionType(id: 1, name: "Clinical", access: "write"),
            area: Area(id: 1, name: "Emergency ICU"),
            survey: Survey(id: 1, categories: [
                Category(id: 1, name: "Drugs", questions: [
                    Question(id: 1, name: "Is the drugs trolley locked?", answerChoices: [
                        AnswerChoice(id: 1, name: "Yes", score: 1.0),
                        AnswerChoice(id: 2, name: "No", score: 0.0)
                    ], selectedAnswerChoiceId: 1)
                ])
            ])
        )

        
        inspection = sampleInspection
        showInspectionView = true
    }
}
