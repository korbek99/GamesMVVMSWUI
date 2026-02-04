//
//  GamesView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//
import SwiftUI

struct GamesView: View {
    @StateObject var viewModel = GamesViewModel()
    
    init() {
        UICollectionView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView().tint(.yellow).scaleEffect(1.5)
                        Text("CARGANDO ARENA...").foregroundColor(.yellow).padding()
                        Spacer()
                    } else {
                        List(viewModel.games) { game in
                            
                            NavigationLink(destination: GamesDetailsView(game: game)) {
                                gameRow(game: game)
                            }
                            .listRowBackground(Color.black)
                            .listRowSeparatorTint(.yellow.opacity(0.3))
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("GAMER LIST")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
        .onAppear {
            viewModel.fetchGames()
        }
    }
    
    @ViewBuilder
    private func gameRow(game: Game) -> some View {
        HStack(alignment: .top, spacing: 15) {
            AsyncImage(url: game.thumbnail) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 90)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.yellow.opacity(0.5), lineWidth: 1))
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 90, height: 60)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(game.title)
                    .font(.headline)
                    .foregroundColor(.yellow)
                
                Text(game.genre ?? "Game")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    GamesView()
}
