//
//  MovieViewPresenter.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 09/05/22.
//

import Foundation
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class MovieViewPresenter {
    
    // MARK: - Properties
    weak var view: MovieViewProtocol?
    var interactor: MovieViewInteractorInputProtocol?
    var wireFrame: MovieViewWireFrameProtocol?
    
}

// MARK: - MovieViewPresenterProtocol
extension MovieViewPresenter: MovieViewPresenterProtocol {
    
    // MARK: Request data from Interactor
    func requestPopularMovieData(urlString: String) {
        self.interactor?.requestPopularMovieData(urlString: urlString)
    }
}

// MARK: - MovieViewInteractorOutputProtocol
extension MovieViewPresenter: MovieViewInteractorOutputProtocol {
   
    // MARK: Send events back to view
    func showFailError(error: String) {
        self.view?.showFailError(error: error)
    }
    
    func reloadMovieData(movieViewModel: [MovieViewModel], totalCount: Int) {
        view?.reloadMovieData(movieViewModel: movieViewModel, totalCount: totalCount)
    }
}
