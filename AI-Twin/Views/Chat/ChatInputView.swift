//
//  ChatInputView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import SwiftUI

struct ChatInputView: View {
    @State private var message: String = ""
    var onSend: (String) -> Void

    var body: some View {
        HStack(spacing: 12) {
            TextField("Type a message...", text: $message)
                .padding(12)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundColor(.primary)

            Button(action: {
                if !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    onSend(message)
                    message = ""
                }
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.accent)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Capsule().fill(.gray.opacity(0.1)))
        .padding(.bottom, 10)
        .padding(.horizontal)
    }
}

#Preview {
    ChatInputView { message in
        print("Sent message: \(message)")
    }
}
