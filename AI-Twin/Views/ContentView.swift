//
//  ContentView.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var dismissLoading = false
    
    var body: some View {
        ZStack{
            SessionsListView()
            
            if !dismissLoading {
                LaunchView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            dismissLoading.toggle()
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
