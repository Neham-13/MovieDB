//
//  MovieViewProtocol.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 09/05/22.
//

import Foundation
import UIKit
/// Method contract between PRESENTER -> VIEW
protocol MovieViewProtocol: AnyObject {
    var presenter: MovieViewPresenterProtocol? { get set }
    
    func showFailError(error:String)
    func reloadMovieData(movieViewModel: [MovieViewModel], totalCount: Int)
}

/// Method contract between VIEW -> PRESENTER
protocol MovieViewPresenterProtocol: AnyObject {
    var view: MovieViewProtocol? { get set }
    var interactor: MovieViewInteractorInputProtocol? { get set }
    var wireFrame: MovieViewWireFrameProtocol? { get set }
    
    func requestPopularMovieData(urlString: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol MovieViewWireFrameProtocol: AnyObject {
    static func presentMovieViewModule() -> MovieVC
}

/// Method contract between PRESENTER -> INTERACTOR
protocol MovieViewInteractorInputProtocol: AnyObject {
    var presenter: MovieViewInteractorOutputProtocol? { get set }
    func requestPopularMovieData(urlString: String)
}

/// Method contract between INTERACTOR -> PRESENTER
protocol MovieViewInteractorOutputProtocol: AnyObject {
    func showFailError(error: String)
    func reloadMovieData(movieViewModel: [MovieViewModel], totalCount: Int)
}
