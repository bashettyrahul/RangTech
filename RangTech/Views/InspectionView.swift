//
//  InspectionView.swift
//  RangTech
//
//  Created by Rahul Bashetty on 18/08/24.
//

import SwiftUI

struct InspectionView: View {
    let inspection: Inspection
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Inspection ID: \(inspection.id)")
                .font(.headline)
            
            Text("Inspection Type: \(inspection.inspectionType.name)")
                .font(.subheadline)
            
            Text("Area: \(inspection.area.name)")
                .font(.subheadline)
            
            ForEach(inspection.survey.categories, id: \.id) { category in
                Text("Category: \(category.name)")
                    .font(.title2)
                
                ForEach(category.questions, id: \.id) { question in
                    Text("Question: \(question.name)")
                        .font(.body)
                    
                    ForEach(question.answerChoices, id: \.id) { answer in
                        Text("Answer Choice: \(answer.name) - Score: \(answer.score, specifier: "%.1f")")
                            .font(.caption)
                            .padding(.leading, 10)
                    }
                }
            }
        }
        .padding()
        .navigationBarItems(trailing: Button("Logout") {
            
            self.presentationMode.wrappedValue.dismiss()
        })
    }
}
