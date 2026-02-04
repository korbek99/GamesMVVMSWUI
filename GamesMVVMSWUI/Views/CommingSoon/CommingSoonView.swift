//
//  CommingSoonView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 03-02-26.
//
import SwiftUI

struct CommingSoonView: View {
   
    @StateObject var viewModel = GamesViewModel()
    
    init() {
        UICollectionView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                   
                    VStack(spacing: 10) {
                        Image(systemName: "clock.badge.exclamationmark.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                        
                        Text("PRÓXIMAMENTE")
                            .font(.system(size: 22, weight: .black, design: .monospaced))
                            .foregroundColor(.white)
                        
                        Text("Títulos en fase de pruebas")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 25)

                    if viewModel.isLoading {
                        Spacer()
                        ProgressView().tint(.yellow)
                        Spacer()
                    } else {
                        
                        List(viewModel.games.prefix(5)) { game in
                            NavigationLink(destination: GamesDetailsView(game: game)) {
                                gameRow(game: game)
                            }
                            .listRowBackground(Color.black)
                            .listRowSeparatorTint(.yellow.opacity(0.3))
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                    
                   
                    Text("Sincronizando con el servidor central...")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(.yellow.opacity(0.5))
                        .padding(.bottom, 10)
                }
            }
            .navigationTitle("ARENA")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        }
        .onAppear {
           
            viewModel.selectedPlatform = .pc
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
                        .frame(width: 110, height: 70)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.yellow.opacity(0.5), lineWidth: 1))
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 110, height: 70)
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
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CommingSoonView()
}
