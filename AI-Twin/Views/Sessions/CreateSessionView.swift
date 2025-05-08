//
//  CreateSessionView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import SwiftUI

struct CreateSessionView: View {
    @ObservedObject var viewModel: SessionsViewModel

    @Binding var showAIChat: Bool
    @Binding var showNewSession: Bool

    @State private var sessionTitle = ""
    @State private var selectedCategory: SessionCategory = .career
    @State private var showAlert = false

    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 30){
                // Top bar
                ZStack{
                    HStack{
                        Button{
                            showNewSession = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .foregroundStyle(.color1)
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    Text("Create Session")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.black)
                }
                .padding(.top)
                
                // Session Title
                VStack(alignment: .leading, spacing: 6) {
                    Text("Session Title")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)
                    
                    TextField("Enter session title", text: $sessionTitle)
                        .foregroundStyle(.black)
                        .font(.system(size: 15, weight: .semibold))
                        .padding()
                        .background(.gray.opacity(0.1))
                        .cornerRadius(12)
                    
                }
                .padding(.horizontal)

                // Category Picker
                VStack(alignment: .leading, spacing: 6) {
                    Text("Category")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)

                    CustomCategoryPicker(selectedCategory: $selectedCategory)
                }
                .padding(.horizontal)

                Spacer()
                
                // Start Session Button
                Button{
                    if sessionTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                           showAlert = true
                           return
                       }

                    viewModel.addSession(title: sessionTitle, category: selectedCategory)

                    showNewSession = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showAIChat = true
                    }
                } label: {
                    Text("Start Session")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Capsule().fill(.color1))
                }
                .padding(.horizontal, 20)
                .padding(.bottom)
            }
        }
        .alert("Invalid Title", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter a valid session title.")
        }
    }
}

#Preview {
    CreateSessionView(viewModel: SessionsViewModel(), showAIChat: .constant(false), showNewSession: .constant(false))
}
