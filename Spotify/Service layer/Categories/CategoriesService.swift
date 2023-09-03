//
//  CategoriesService.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

protocol ICategoriesService {
    func getCategories(limit: Int, completion: @escaping ((Result<AllCategoriesResponse, Error>) -> Void))
    func getCategoryPlaylists(categoryID: String, limit: Int, completion: @escaping ((Result<CategoriesPlaylistsResponse , Error>) -> Void))
}

final class CategoriesService: ICategoriesService {
    
    // MARK: - Dependencies
    
    private let requestProcessor: IRequestProcessor
    
    // MARK: - Init
    
    init(requestProcessor: Lazy<IRequestProcessor>) {
        self.requestProcessor = requestProcessor.get()
    }
    
    // MARK: - ICategoriesService
    
    func getCategories(limit: Int, completion: @escaping ((Result<AllCategoriesResponse, Error>) -> Void)) {
        let endpoint = CategoriesEndpoint.getCategories(limit: limit)
        requestProcessor.load(endpoint, completion: completion)
    }
    func getCategoryPlaylists(categoryID: String, limit: Int, completion: @escaping ((Result<CategoriesPlaylistsResponse, Error>) -> Void)) {
        let endpoint = CategoriesEndpoint.getCategoryPlaylists(categoryID: categoryID, limit: limit)
        requestProcessor.load(endpoint, completion: completion)
    }
}
