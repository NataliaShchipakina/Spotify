//
//  Endpoint.swift
//  Spotify
//
//  Created by Eugene Dudkin on 22.07.2023.
//

import Foundation

protocol Endpoint {
    /// Определяет базовый URL для запроса.
    var baseURL: String { get }

    /// Дополнительный путь, который будет добавлен к `baseURL` для формирования полного URL запроса.
    var path: String { get }

    /// HTTP метод, используемый для отправки запроса.
    var httpMethod: HTTPMethod { get }

    /// Заголовки HTTP, которые будут отправлены вместе с запросом.
    var headers: [String: String]? { get }

    /// Параметры запроса, которые будут добавлены в url запроса.
    var urlQueryParameters: [URLQueryItem] { get }
    
    /// Параметры запроса, которые будут добавлены в httpBody
    var httpBodyQueryParameters: [URLQueryItem] { get }

    /// Способ декодирования ответов
    var decoder: JSONDecoder { get }
}
