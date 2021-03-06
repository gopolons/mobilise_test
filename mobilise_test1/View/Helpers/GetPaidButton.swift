//
//  GetPaidButton.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 25/11/2021.
//

import SwiftUI

struct GetPaidButton: View {
    
    @Binding var isLoading: Bool
    @State private var isAnimating = false
    
    private var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    let function: () -> Void
    
    var body: some View {
        Button {
            if isLoading {
                withAnimation {
                    isLoading.toggle()
                }
            } else {
                function()
                withAnimation {
                    isLoading.toggle()
                }
            }
        } label: {
            
            ZStack {
                Circle()
                    .foregroundColor(isLoading ? .gray : .blue)
                
                if isLoading {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                        .animation(self.isAnimating ? foreverAnimation : .default)
                        .onAppear { self.isAnimating = true }
                        .onDisappear { self.isAnimating = false }
                        
                } else {
                    Text("Request amount")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                

            }
            .frame(width: 100, height: 100)
        }
        .buttonStyle(PlainButtonStyle())

    }
}

struct GetPaidButton_Previews: PreviewProvider {
    
    @State static var previewBind = false
    
    static var previews: some View {
        GetPaidButton(isLoading: $previewBind, function: {})
    }
}
