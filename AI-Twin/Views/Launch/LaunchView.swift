//
//  LaunchView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import SwiftUI

struct LaunchView: View {
    @State private var iconScale: CGFloat = 0
    @State private var dot1Visible = false
    @State private var dot2Visible = false
    @State private var dot3Visible = false

    var body: some View {
        ZStack {
            Color.color1.ignoresSafeArea()
            
            VStack {
                Spacer()

                Image("launch")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                    .cornerRadius(20)
                    .scaleEffect(iconScale)
                    .onAppear {
                        withAnimation(.spring(duration: 0.8)) {
                            iconScale = 1
                        }
                    }
                
                Spacer()
                
                HStack(spacing: 10) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.color3)
                        .opacity(dot1Visible ? 1 : 0)

                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.color3)
                        .opacity(dot2Visible ? 1 : 0)

                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.color3)
                        .opacity(dot3Visible ? 1 : 0)
                }
                .padding(10)
                .padding(.horizontal, 10)
                .background(.color2.opacity(0.5))
                .cornerRadius(30)
                .padding(.bottom, 40)
                .onAppear {
                    startDotAnimation()
                }
            }
        }
    }
    
    private func startDotAnimation() {
        let duration = 1.2
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            withAnimation(.spring(duration: duration / 2)) {
                dot1Visible = true
                dot2Visible = false
                dot3Visible = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration / 3) {
                withAnimation(.spring(duration: duration / 2)) {
                    dot1Visible = false
                    dot2Visible = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 * duration / 3) {
                withAnimation(.spring(duration: duration / 2)) {
                    dot2Visible = false
                    dot3Visible = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                withAnimation(.spring(duration: duration / 2)) {
                    dot3Visible = false
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}

