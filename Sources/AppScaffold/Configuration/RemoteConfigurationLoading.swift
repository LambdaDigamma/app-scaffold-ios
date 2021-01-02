//
//  RemoteConfigLoading.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

import Foundation
import Combine

protocol RemoteConfigurationLoading {

    associatedtype Configuration

    func fetch() -> AnyPublisher<Configuration, Error>
    
}

class AnyRemoteConfigurationLoader<Configuration>: RemoteConfigurationLoading {
    
    private let _fetch: () -> AnyPublisher<Configuration, Error>
    
    init<Loader: RemoteConfigurationLoading>(remoteConfigurationLoader: Loader) where Loader.Configuration == Configuration {
        _fetch = remoteConfigurationLoader.fetch
    }
    
    func fetch() -> AnyPublisher<Configuration, Error> {
        return _fetch()
    }
    
}

class DefaultRemoteConfigurationLoader<Configuration: AppConfigurable>: RemoteConfigurationLoading {
    
    let configurationURL: URL
    
    init(configurationURL: URL) {
        self.configurationURL = configurationURL
    }
    
    func fetch() -> AnyPublisher<Configuration, Error> {
        return URLSession.shared.dataTaskPublisher(for: configurationURL)
            .map(\.data)
            .decode(type: Configuration.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
