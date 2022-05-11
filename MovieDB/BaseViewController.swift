//
//  BaseViewController.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 11/05/22.
//

import UIKit

class BaseViewController: UIViewController {

    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func movieURL(matching apiKey:String, page: String) -> String {
        let api = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)"
        //let url = URL((string: api) ?? "")
        return api
    }
}

// MARK: - Handle Empty State for UICollectionView
extension BaseViewController {
    
    /// Sets a message in a label if the collection view has no items to show
    ///
    /// - Parameters:
    ///   - collectionView: Collectionview where the items are going to be shown
    ///   - array: array of items to be shown
    ///   - emptyMessage: String with the empty message
    func setupEmptyMessageIfNeeded(collectionView: UICollectionView, array: [Any], emptyMessage: String!) {
        collectionView.backgroundView = nil
        if !(array.count > 0) {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
            noDataLabel.text = emptyMessage
            noDataLabel.numberOfLines = 0
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            collectionView.backgroundView = noDataLabel
        }
    }
}
