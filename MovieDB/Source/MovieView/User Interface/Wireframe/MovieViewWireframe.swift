//
//  MovieViewWireframe.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 09/05/22.
//

import Foundation
/// Wireframe that handles all routing between views
class MovieViewWireFrame: MovieViewWireFrameProtocol {
    
    // MARK: - Present MovieView Screen
    /// Class method that initializes  MovieView module
    static func presentMovieViewModule() -> MovieVC {
        // Generating module components
        let view: MovieViewProtocol = MovieVC.instantiate()
        let presenter: MovieViewPresenterProtocol & MovieViewInteractorOutputProtocol = MovieViewPresenter()
        let interactor: MovieViewInteractorInputProtocol = MovieViewInteractor()
        let wireFrame: MovieViewWireFrameProtocol = MovieViewWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view as! MovieVC
    }
}
