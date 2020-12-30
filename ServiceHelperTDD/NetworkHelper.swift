//
//  NetworkHelper.swift
//  ServiceHelperTDD
//
//  Created by Nikhil Dange on 30/12/20.
//  Copyright © 2020 Nikhil Dange. All rights reserved.
//

import Foundation

typealias MovieResponse = (MoviePage?,MovieAPIError?) -> ()

enum MovieAPIError: Error {
    case unknown
    case invalidResponse
    case failedRequest
    case invalidURLRequest
    case emptyResponse
}

protocol NetworkHelperProtocol {
    func callMoviesData(on page: Int, completion: @escaping MovieResponse)
}

struct NetworkHelper: NetworkHelperProtocol {
    
    // MARK: - Properties
    
    static let shared = NetworkHelper()
    static let sharedForTest = NetworkHelper()
    
    
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/trending/movie/week"
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value:"8eac22f4c24d01c480e4d99fef2edfc3")]
        return urlComponents
    }
    
    // MARK: - Private Init
    
    private init() {}
    
    //MARK: - Requesting Data
    
    func callMoviesData(on page: Int, completion: @escaping MovieResponse)
    {
        var urlComponents = self.urlComponents
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        guard let url = urlComponents.url else {
            completion(nil, .invalidURLRequest)
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler:{ (data,response,error) in
            if let error = error {
                completion(nil, .failedRequest)
                print("Unable to fetch User Data, \(error)")
            }
            else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let data = try JSONDecoder().decode(MoviePage.self, from: data)
                        completion(data,nil)
                    } catch {
                        completion(nil,.invalidResponse)
                        print("Unable to decode response, \(error)")
                    }
                }
                else {
                    completion(nil, .failedRequest)
                    print("Error in Status Code, \(response.statusCode)")
                }
            }
            else {
                completion(nil, .unknown)
                print("Unknown Error")
            }
        })
        task.resume()
    }
    
}

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
        
        networkHelper.callMoviesData(on: page) {
            (data, error) in
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
