//
//  ChatBubbleView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import SwiftUI

struct ChatBubbleView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.sender == .user {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(.accent)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .frame(maxWidth: 300, alignment: .trailing)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                    .foregroundColor(.black)
                    .frame(maxWidth: 300, alignment: .leading)
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top, 5)
    }
}

#Preview {
    ChatBubbleView(message: Message(text: "Hello", sender: .user))
}
