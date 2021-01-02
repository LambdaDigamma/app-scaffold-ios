//
//  ConfigurationProvider.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

import Foundation
import Combine

class ConfigurationProvider<Configuration: AppConfigurable> {

    @Published private(set) var configuration: Configuration
    
    private let localConfigurationLoader: AnyLocalConfigurationLoader<Configuration>
    private let remoteConfigurationLoader: AnyRemoteConfigurationLoader<Configuration>
    
    init(remoteConfigurationLoader: AnyRemoteConfigurationLoader<Configuration>,
         localConfigurationLoader: AnyLocalConfigurationLoader<Configuration>) {

        self.remoteConfigurationLoader = remoteConfigurationLoader
        self.localConfigurationLoader = localConfigurationLoader

    }
    
    private var cancellable: AnyCancellable?
    private var syncQueue = DispatchQueue(label: "config_queue_\(UUID().uuidString)")

    func updateConfiguration() {

        syncQueue.sync {

            guard self.cancellable == nil else {
                return
            }

            self.cancellable = self.remoteConfigurationLoader.fetch()
                .sink(receiveCompletion: { completion in
                    self.cancellable = nil // clear cancellable so we could start a new load
                }, receiveValue: { [weak self] newConfiguration in
                    self?.configuration = newConfiguration
                    self?.localConfigurationLoader.persist(newConfiguration)
                })

        }

    }

}
