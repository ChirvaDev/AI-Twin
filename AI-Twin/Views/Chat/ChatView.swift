//
//  ChatView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Binding var showAIChat: Bool
    @State private var sessionId: String = "session123"
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                ZStack{
                    HStack{
                        Button{
                            showAIChat = false
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
                    
                    Text("AI Chat")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.black)
                }
                .padding(.top)
                
                // Відображення повідомлень у вигляді чату
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        ForEach(viewModel.messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: viewModel.messages) { _ in
                        if let lastMessage = viewModel.messages.last {
                            scrollProxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                
                Spacer()
                
                ChatInputView { message in
                    Task {
                        await viewModel.sendMessage(message, sessionId: sessionId)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadMessages(sessionId: sessionId)
            }
        }
    }
}

#Preview {
    ChatView(showAIChat: .constant(false))
}
