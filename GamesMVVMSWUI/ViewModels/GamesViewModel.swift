//
//  GamesViewModel.swift
//  GamesMVVMSWUI
//
//  Created by Jose Preatorian on 04-02-26.
//

import Foundation
import SwiftUI

class GamesViewModel: ObservableObject {
    
    // MARK: - Published Properties (Estado de la UI)
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Filtros seleccionados
    @Published var selectedPlatform: GamePlatform = .all
    @Published var selectedCategory: GameCategory = .mmorpg
    @Published var selectedSort: GameSort = .popularity
    
    // MARK: - Dependencies
    private let webService: WebServiceGameProtocol
    
    // Inyectamos el servicio mediante el protocolo
    init(webService: WebServiceGameProtocol = WebServiceGame()) {
        self.webService = webService
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func fetchGames() {
        self.isLoading = true
        self.errorMessage = nil
        
        webService.getGames(
            platform: selectedPlatform,
            category: selectedCategory,
            sortBy: selectedSort
        ) { [weak self] result in
            // Regresamos al hilo principal para actualizar la UI
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let fetchedGames):
                    self?.games = fetchedGames
                case .failure(let error):
                    self?.errorMessage = "Error al cargar juegos: \(error.localizedDescription)"
                    print("❌ Error en ViewModel: \(error)")
                }
            }
        }
    }
    
    // Método para limpiar filtros o reiniciar búsqueda
    @MainActor func resetFilters() {
        selectedPlatform = .all
        selectedSort = .popularity
        fetchGames()
    }
}
