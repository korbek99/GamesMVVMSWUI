//
//  CommingSoonView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//

import SwiftUI
import SwiftUI

struct CommingSoonView: View {
    var body: some View {
        ZStack {

            Color.black
                .ignoresSafeArea()
 
            VStack(spacing: 20) {
                Image(systemName: "clock.badge.exclamationmark.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow) 
                
                Text("COMING SOON")
                    .font(.system(size: 28, weight: .black, design: .monospaced))
                    .foregroundColor(.white)
                
                Text("Esta sección está en desarrollo, entrenador.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CommingSoonView()
}
