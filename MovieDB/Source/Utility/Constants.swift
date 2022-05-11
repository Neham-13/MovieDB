//
//  Constants.swift
//  MovieDB
//
//  Created by Neha2 Mishra on 11/05/22.
//

import Foundation
// MARK: - StringConstants
struct StringConstants {
    // MARK: Empty Data
    static let noDataAvailable = "No Data Available."
    static let emptyApiKey = "Please make sure that you have provided an API key."
 
    // MARK: Error
    static let errorOccured = "An error occured"
    
    // MARK: APIs
    static let movieURL: String = "https://api.themoviedb.org/3/movie/popular?api_key=" + apiKey + "&page="
    static let imageBaseURL : String = "https://image.tmdb.org/t/p/w500/"
    static let apiKey : String = "d30673d0ac03ca701dd460dac3ec1eeb"
    
    // MARK: Test case message
    static let successCase = "Success."
    static let parseErrorCase = "Error in parsing."
    static let dataNilCase = "Data is nil."
}
