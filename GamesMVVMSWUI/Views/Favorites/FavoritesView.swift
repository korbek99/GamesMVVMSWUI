//
//  FavoritesView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        ZStack {

            Color.black
                .ignoresSafeArea()
 
            VStack(spacing: 20) {
                Image(systemName: "clock.badge.exclamationmark.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
                
                Text("Favorites")
                    .font(.system(size: 28, weight: .black, design: .monospaced))
                    .foregroundColor(.white)
                
                Text("Mis juegos Favoritos.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    FavoritesView()
}
