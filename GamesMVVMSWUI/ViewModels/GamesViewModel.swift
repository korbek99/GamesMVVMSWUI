//
//  GamesViewModel.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI

class GamesViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
 
    @Published var searchText = ""
    @Published var selectedPlatform: GamePlatform = .all
    @Published var selectedCategory: GameCategory = .mmorpg
    @Published var selectedSort: GameSort = .popularity
    

    var filteredGames: [Game] {
        if searchText.isEmpty {
            return games
        } else {
            return games.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private let webService: WebServiceGameProtocol
    
    init(webService: WebServiceGameProtocol = WebServiceGame()) {
        self.webService = webService
    }
    
    @MainActor
    func fetchGames() {
        self.isLoading = true
        self.errorMessage = nil
        
        webService.getGames(
            platform: selectedPlatform,
            category: nil, 
            sortBy: selectedSort
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedGames):
                    self?.games = fetchedGames
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
