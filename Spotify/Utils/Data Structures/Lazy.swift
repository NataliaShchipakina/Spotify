//
//  Lazy.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

/// Контейнер для ленивой инициализации значения.
final class Lazy<T> {

    private enum State {
        case uninitialized(() -> T)
        case initialized(T)
    }

    private var state: State

    // MARK: - Initialization

    /// Создаёт новый экземпляр контейнера.
    ///
    /// - Parameter factory: Фабрика значения для контейнера.
    public init(_ factory: @autoclosure @escaping () -> T) {
        state = .uninitialized(factory)
    }

    // MARK: - Methods

    /// Возвращает значение из контейнера, выполняя инициализацию, если это необходимо.
    public func get() -> T {
        switch state {
        case .uninitialized(let factory):
            let instance = factory()
            state = .initialized(instance)
            return instance
        case .initialized(let instance):
            return instance
        }
    }
}
