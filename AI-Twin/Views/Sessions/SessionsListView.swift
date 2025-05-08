//
//  SessionsListView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import SwiftUI

struct SessionsListView: View {
    @StateObject private var viewModel = SessionsViewModel()
    
    @State private var showNewSession = false
    @State private var showAIChat = false
    @State private var showLoadingOverlay = false
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                ZStack{
                    HStack{
                        Spacer()
                        
                        Button{
                            withAnimation {
                                showLoadingOverlay = true
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                Task {
                                    await viewModel.fetchSessions()
                                    withAnimation {
                                        showLoadingOverlay = false
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .foregroundStyle(.color1)
                        }
                    }
                    .padding(.trailing, 20)
                    
                    Text("AI Sessions")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.black)
                }
                .padding(.top)
                
                
                if showLoadingOverlay {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .color1))
                            .scaleEffect(1.2)
                    }
                    .transition(.opacity)
                }
                
                Spacer()
                
                // List of Sessions
                if viewModel.sessions.isEmpty {
                    if viewModel.isLoading {
                        ProgressView().padding()
                            .foregroundStyle(.color1)
                    } else {
                        Spacer()
                        Text("No sessions found")
                            .foregroundStyle(.gray)
                            .padding()
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.sortedSessions) { session in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(session.title)
                                            .font(.system(size: 16, weight: .bold))

                                        Spacer()
                                        
                                        Text(session.category.capitalized)
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Capsule().fill(Color.color1.opacity(0.3)))
                                    }
                                    Text(session.summary)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(.gray)
                                    
                                    Text(session.formattedDate)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(.gray)
                                }
                                .padding()
                                .foregroundStyle(.black)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
                
                Spacer()

                Button{
                    showNewSession.toggle()
                } label: {
                    Text("Start new session")
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
        .task {
            print("🔄 ViewModel.task виконано")
            await viewModel.fetchSessions()
        }
        .sheet(isPresented: $showNewSession){
            CreateSessionView(
                viewModel: viewModel,
                showAIChat: $showAIChat,
                showNewSession: $showNewSession
            )
        }
        .fullScreenCover(isPresented: $showAIChat){
            ChatView(showAIChat: $showAIChat)
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    SessionsListView()
}

