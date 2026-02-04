//
//  GamesDetailsView.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//
import SwiftUI

struct GamesDetailsView: View {
    let game: Game
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                AsyncImage(url: game.thumbnail) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.3)
                        ProgressView().tint(.yellow)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipped()
                .overlay(
                    Rectangle()
                        .stroke(Color.yellow, lineWidth: 1)
                )

                VStack(alignment: .leading, spacing: 20) {

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text(game.title)
                                .font(.system(size: 28, weight: .black, design: .monospaced))
                                .foregroundColor(.yellow)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                            
                            Text(game.genre ?? "Game")
                                .font(.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .bold()
                                .cornerRadius(4)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("INFO TÉCNICA")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.yellow.opacity(0.8))
                        
                        Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 8) {
                            detailRow(title: "PLATAFORMA", value: game.platform ?? "N/A")
                            detailRow(title: "DESARROLLADOR", value: game.developer ?? "N/A")
                            detailRow(title: "PUBLISHER", value: game.publisher ?? "N/A")
                            detailRow(title: "LANZAMIENTO", value: game.releaseDate ?? "N/A")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(10)

                    Divider().background(Color.yellow.opacity(0.3))

  
                    VStack(alignment: .leading, spacing: 50) {
                        Text("RESUMEN")
                            .font(.headline)
                            .foregroundColor(.yellow)
                        
                        Text(game.shortDescription ?? "Sin descripción disponible.")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(6)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 20) 
                .padding(.top, 20)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailRow(title: String, value: String) -> some View {
        GridRow {
            Text(title)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 13))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    let mockGame = Game(
        id: 1,
        title: "Overwatch 2",
        thumbnail: URL(string: "https://www.freetogame.com/g/540/thumbnail.jpg"),
        shortDescription: "A team-based action game set in the optimistic future, where every match is the ultimate 5v5 battlefield brawl.",
        gameURL: URL(string: "https://www.freetogame.com/open/overwatch-2"),
        genre: "Shooter",
        platform: "PC (Windows)",
        publisher: "Activision Blizzard",
        developer: "Blizzard Entertainment",
        releaseDate: "2022-10-04",
        freetogameProfileURL: URL(string: "https://www.freetogame.com/overwatch-2")
    )

    return NavigationStack {
        GamesDetailsView(game: mockGame)
    }
}
