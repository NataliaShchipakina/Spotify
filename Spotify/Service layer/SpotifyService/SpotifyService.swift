//
//  APICaller.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import Foundation

protocol ISpotifyService {
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void)
    func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void)
    func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void))
    func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse , Error>) -> Void))
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<String , Error>) -> Void))
}

final class SpotifyService: ISpotifyService {
    @available(*, deprecated, message: "Pls use DI instead")
    static let shared = SpotifyService()
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let requestHandler: (URLRequest) -> Void = { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET, completion: requestHandler)
        
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=2"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse , Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<String , Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations?seed_genres=\(seeds)"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("json: \(result)")
                    //  JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    // completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }

    }



//    MARK: - Private

enum HTTPMethod:String {
    case GET
    case POST
}

private func createRequest(with url: URL?,
                           type: HTTPMethod,
                           completion: @escaping (URLRequest) -> Void) {
    AuthetificationService.shared.withValidToken { token in
        guard let apiURL = url else {
            return
        }
        var request = URLRequest(url: apiURL)
        request.setValue("Bearer \(token)",
                         forHTTPHeaderField: "Authorization")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}
}

