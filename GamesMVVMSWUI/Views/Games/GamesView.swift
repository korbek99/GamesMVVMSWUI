//
//  GamesView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//
import SwiftUI

struct GamesView: View {
    @StateObject var viewModel = GamesViewModel()

    private let platforms: [GamePlatform] = [.all, .pc, .browser]
    
    init() {
        UICollectionView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {

                    filterBar
                        .padding(.vertical, 12)
                    
                    if viewModel.isLoading && viewModel.games.isEmpty {
                        Spacer()
                        ProgressView().tint(.yellow).scaleEffect(1.5)
                        Text("CARGANDO ARENA...").foregroundColor(.yellow).padding()
                        Spacer()
                    } else {
                        List(viewModel.filteredGames) { game in
                            NavigationLink(destination: GamesDetailsView(game: game)) {
                                gameRow(game: game)
                            }
                            .listRowBackground(Color.black)
                            .listRowSeparatorTint(.yellow.opacity(0.3))
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        
                        if viewModel.filteredGames.isEmpty && !viewModel.searchText.isEmpty {
                            ContentUnavailableView.search(text: viewModel.searchText)
                                .preferredColorScheme(.dark)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            .navigationTitle("GAMER LIST")
            .searchable(text: $viewModel.searchText, prompt: "Buscar juego...")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
        .onAppear {
            if viewModel.games.isEmpty {
                viewModel.fetchGames()
            }
        }
    }
    
    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(platforms, id: \.self) { platform in
                    Button(action: {
                        viewModel.selectedPlatform = platform
                        viewModel.fetchGames()
                    }) {
                        Text(platform.rawValue.uppercased())
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(viewModel.selectedPlatform == platform ? Color.yellow : Color.yellow.opacity(0.1))
                            .foregroundColor(viewModel.selectedPlatform == platform ? .black : .yellow)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.yellow.opacity(0.5), lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
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
                
                Text(game.platform ?? "PC")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    GamesView()
}
