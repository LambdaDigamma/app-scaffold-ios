//
//  LocalConfigurationLoading.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

import Foundation
import Combine

protocol LocalConfigurationLoading {
    
    associatedtype Configuration
    
    func fetch() -> Configuration
    func persist(_ configuration: Configuration)
    
}

class AnyLocalConfigurationLoader<Configuration>: LocalConfigurationLoading {
    
    private let _fetch: () -> Configuration
    private let _persist: (_ configuration: Configuration) -> ()
    
    init<Loader: LocalConfigurationLoading>(localConfigurationLoader: Loader) where Loader.Configuration == Configuration {
        _fetch = localConfigurationLoader.fetch
        _persist = localConfigurationLoader.persist
    }
    
    func fetch() -> Configuration {
        _fetch()
    }
    
    func persist(_ configuration: Configuration) {
        _persist(configuration)
    }
}

class DefaultLocalConfigurationLoader<Configuration: AppConfigurable>: LocalConfigurationLoading {
    
    /// Save your configuration json file in your project which is bundled into your app.
    /// Defaults to `config.json`.
    public let configurationFileName: String
    
    init(configurationFileName: String = "config.json") {
        self.configurationFileName = configurationFileName
    }
    
    private var cachedConfigUrl: URL? {

        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        return documentsUrl.appendingPathComponent(configurationFileName)
    }

    private var cachedConfig: Configuration? {
        let jsonDecoder = JSONDecoder()

        guard let configUrl = cachedConfigUrl,
              let data = try? Data(contentsOf: configUrl),
              let config = try? jsonDecoder.decode(Configuration.self, from: data) else {
            return nil
        }

        return config
    }

    private var defaultConfig: Configuration {

        let jsonDecoder = JSONDecoder()

        guard let url = Bundle.main.url(forResource: configurationFileName.replacingOccurrences(of: ".json", with: ""), withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let config = try? jsonDecoder.decode(Configuration.self, from: data) else {
            fatalError("Bundle must include default config. Check and correct this mistake.")
        }

        return config
    }

    func fetch() -> Configuration {

        if let cachedConfig = self.cachedConfig {
            return cachedConfig
        } else {
            let config = self.defaultConfig
            persist(config)
            return config
        }

    }

    func persist(_ config: Configuration) {

        guard let configUrl = cachedConfigUrl else {
            // should never happen, you might want to handle this
            return
        }

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(config)
            try data.write(to: configUrl)
        } catch {
            // you could forward this error somewhere
            print(error)
        }

    }
    
}
