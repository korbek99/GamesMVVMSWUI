//
//  FavoritesView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query private var favoriteEntities: [FavoriteGame]
    @StateObject var viewModel = GamesViewModel()
    
    init() {
        UICollectionView.appearance().backgroundColor = .clear
    }

    var favoriteGamesFromServer: [Game] {
        let favoriteIDs = Set(favoriteEntities.map { $0.id })
        return viewModel.games.filter { favoriteIDs.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    if viewModel.isLoading && viewModel.games.isEmpty {
                        loadingState
                    } else if favoriteEntities.isEmpty {
                        emptyState
                    } else {
                        favoritesList
                    }
                }
            }
            .navigationTitle("MIS FAVORITOS")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
        .onAppear {
            if viewModel.games.isEmpty {
                viewModel.fetchGames()
            }
        }
    }
    
    
    private var loadingState: some View {
        VStack {
            Spacer()
            ProgressView().tint(.yellow).scaleEffect(1.5)
            Text("SINCRONIZANDO FAVORITOS...").foregroundColor(.yellow).padding()
            Spacer()
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 50))
                .foregroundColor(.yellow.opacity(0.5))
            Text("NO TIENES FAVORITOS")
                .font(.headline)
                .foregroundColor(.white)
            Text("Explora la arena y guarda tus juegos preferidos.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
    }
    
    private var favoritesList: some View {
        List(favoriteGamesFromServer) { game in
            NavigationLink(destination: GamesDetailsView(game: game)) {
                gameRow(game: game)
            }
            .listRowBackground(Color.black)
            .listRowSeparatorTint(.yellow.opacity(0.3))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    @ViewBuilder
    private func gameRow(game: Game) -> some View {
        HStack(alignment: .top, spacing: 15) {
            AsyncImage(url: game.thumbnail) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 70)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.yellow.opacity(0.5), lineWidth: 1))
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 120, height: 70)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(game.title)
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .lineLimit(1)
                
                Text(game.genre ?? "Action")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.caption2)
                        .foregroundColor(.red)
                    Text(game.platform ?? "PC")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FavoritesView()
        .modelContainer(for: FavoriteGame.self, inMemory: true)
}

