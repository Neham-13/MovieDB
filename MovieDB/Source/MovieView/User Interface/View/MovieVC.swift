//
//  MovieVC.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 09/05/22.
//

import UIKit

class MovieVC: BaseViewController {
    // MARK: - Subviews
    @IBOutlet weak var collectionVW: UICollectionView!
    //Pagination
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var presenter: MovieViewPresenterProtocol?
    var arrMovieData: [MovieViewModel] = []
    private var collectionCell = "MovieCollectionViewCell"
    private var numberOfColumns = 3
    var totalCount: Int = 0
    var page: Int = 1
    var pageLimit = 15
    var isPageRefreshing:Bool = false
    
    // MARK: - MovieVC Constants
    private struct MovieVCConstants {
        static let movieVC = "MovieVC"
    }
    
    // MARK: - View Initiation
    /// Initializes a MovieVC View with the provided parts and specifications
    ///
    /// - Returns:StoryBoard of ManagerActionVC
    static func instantiate() -> MovieViewProtocol {
        return UIStoryboard(name: MovieVCConstants.movieVC, bundle: nil).instantiateViewController(withIdentifier: MovieVCConstants.movieVC) as! MovieVC
    }
    
    /// Overwritten method from UIVIewController, it calls a method to subscribe to keyboard events
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if arrMovieData.count != 0 {
            arrMovieData.removeAll()
            collectionVW.reloadData()
        }
        requestData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionItems()
        requestData()
        // Do any additional setup after loading the view.
    }
}

// MARK: - MovieViewProtocol
extension MovieVC: MovieViewProtocol {
    /// showFailError called when error thrown by server
    ///
    ///- Parameter error: error thrown by server
    func showFailError(error: String) {
        super.showAlert(message: error)
    }
    /// Reload Resource List
    ///
    /// - Parameter arrResources: [RoleValidResourceList]
    func reloadMovieData(movieViewModel: [MovieViewModel], totalCount: Int) {
        isPageRefreshing = true
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
        }
        }
        self.totalCount = totalCount
        if self.arrMovieData.count > 0 {
            self.arrMovieData = self.arrMovieData + movieViewModel
        } else{
            self.arrMovieData = movieViewModel
        }
        DispatchQueue.main.async {
            super.setupEmptyMessageIfNeeded(collectionView: self.collectionVW, array: self.arrMovieData, emptyMessage: StringConstants.noDataAvailable)
        self.collectionVW.reloadData()
        }
    }
}

// MARK: - User Defined Methods
extension MovieVC {
    private func registerCollectionItems() {
        collectionVW.register(UINib(nibName: collectionCell, bundle: nil), forCellWithReuseIdentifier: collectionCell)
    }
    
    private func requestData(){
        self.presenter?.requestPopularMovieData(urlString: StringConstants.movieURL + "\(page)")
    }
    
    @objc func loadMoreData()
    {
        if !(arrMovieData.count >= totalCount) {
            isPageRefreshing = false
            activityIndicator.startAnimating()
            page = page + 20
            requestData()
        }
    }
}

// MARK:- UICollectionViewDataSource
extension MovieVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMovieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as? MovieCollectionViewCell else {
                    return MovieCollectionViewCell()
                }
        cell.setUpMovieCell(details: arrMovieData[indexPath.row])
                return cell
    }
    
}

// MARK:- UICollectionViewDelegate
extension MovieVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isPageRefreshing {
            if(self.collectionVW.contentOffset.y > (self.collectionVW.contentSize.height - self.collectionVW.bounds.size.height))
            {
                self.loadMoreData()
            }
        }
    }
}

extension MovieVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Int((collectionView.bounds.width - 30) / CGFloat(numberOfColumns))
        return CGSize(width: size, height: 200)
    }
    
}



