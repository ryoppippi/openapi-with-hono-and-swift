//
//  ProductionApp.swift
//  Production
//
//  Created by ryoppippi on 2023/08/25.
//

import SwiftUI
import MyDomainsRepositories

public struct ProductionRootScreen: View {
    
    @State private var id  = ""
    @State private var user: User?
    
    @State private var errorMessage: String?
    
    
    public init() { }
    
    public var body: some View {
        VStack {
            TextField(
                "ID",
                text: $id
            )
            .onSubmit {
                Task {
                    do {
                        user = nil
                        errorMessage = nil
                        user = try await getUser(id: id)
                    } catch let error as APIError {
                        print(error)
                        switch error {
                        case .runtimeError(let message, let code):
                            errorMessage = "\(message)\t\(code)"
                        }
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .padding()
            
            Spacer()
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .background(.red)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            if let user = user {
                Text(user.id)
                Text(user.name)
                Text("\(user.age)")
            }
            
            Spacer()
        }
    }
}
