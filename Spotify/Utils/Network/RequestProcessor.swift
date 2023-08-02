//
//  RequestProcessor.swift
//  Spotify
//
//  Created by Eugene Dudkin on 22.07.2023.
//

import Foundation

protocol IRequestProcessor {
    func load<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

final class RequestProcessor: IRequestProcessor {

    // MARK: - Dependencies
    
    private let urlSession: URLSession
    
    // MARK: - Init
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - IRequestProcessor
    
    func load<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard var requestURL = URL(string: endpoint.baseURL + endpoint.path) else { fatalError("Wrong URL string") }
        requestURL.append(queryItems: endpoint.urlQueryParameters)

        var request = URLRequest(url: requestURL)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = endpoint.httpMethod.rawValue
        request.timeoutInterval = 60
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = endpoint.httpBodyQueryParameters
        request.httpBody = urlComponents.query?.data(using: .utf8)
        
        urlSession.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError()))
                return
            }

            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try endpoint.decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
