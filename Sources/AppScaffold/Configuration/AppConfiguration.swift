//
//  AppConfiguration.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

import Foundation

protocol AppConfigurable: Codable {
    var minVersion: String { get set }
}
