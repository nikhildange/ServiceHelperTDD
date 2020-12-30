//
//  MovieServiceHelper.swift
//  ServiceHelperTDD
//
//  Created by Nikhil Dange on 30/12/20.
//  Copyright © 2020 Nikhil Dange. All rights reserved.
//

import Foundation

class MovieServiceHelper {
    
    var networkHelper: NetworkHelperProtocol!
    
    init(networkHelper: NetworkHelperProtocol) {
        self.networkHelper = networkHelper
    }
    
    func getMoviesData(on page: Int, completion: @escaping MovieResponse) {
        
        guard page > 0 && page < 1001 else {
            completion(nil, .invalidURLRequest)
            return
        }
        
        networkHelper.callMoviesData(on: page) { // mock
            (data, error) in
            // validation code
            if let data = data {
                if data.movies.isEmpty {
                    completion(nil, .emptyResponse)
                }
                else {
                    completion(data,nil)
                }
            }
            else {
                completion(data,error)
            }
        }
        
    }
    
}
