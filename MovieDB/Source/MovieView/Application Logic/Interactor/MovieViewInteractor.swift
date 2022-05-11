//
//  MovieViewInteractor.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 09/05/22.
//

import Foundation
fileprivate struct MovieResult: Codable {
    
    var totalResults: Int?
    var page: Int?
    var totalPages: Int?
    var results: Array<MovieViewModel>?
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page = "page"
        case totalPages = "total_pages"
        case results = "results"
    }
    
}
/// Interactor that acts between the interactor and the presenter
class MovieViewInteractor: MovieViewInteractorInputProtocol {
    var movies: Array<MovieViewModel>?
    
    // MARK: - Properties
    weak var presenter: MovieViewInteractorOutputProtocol?
    
    
    // MARK: - Request Data methods
    
    // MARK: Request to perform popular movies data
    ///
    /// - Parameter nil
    func requestPopularMovieData(urlString: String) {
        
        if StringConstants.apiKey.isEmpty {
            self.presenter?.showFailError(error: StringConstants.emptyApiKey)
            return
        }
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            if error != nil {
                self.presenter?.showFailError(error: error?.localizedDescription.description ?? StringConstants.errorOccured)
                return
            }
            guard let data = data else {
                self.presenter?.showFailError(error: StringConstants.errorOccured)
                return
            }
            do {
                if let movies = try JSONDecoder().decode(MovieResult.self, from: data).results {
                    if let totalPages = try JSONDecoder().decode(MovieResult.self, from: data).totalPages{
                        self.presenter?.reloadMovieData(movieViewModel: movies, totalCount: totalPages)
                    }
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}
