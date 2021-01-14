//
//  BootstrappingProcedure.swift
//  
//
//  Created by Lennart Fischer on 03.01.21.
//

#if canImport(UIKit)

import UIKit

public protocol BootstrappingProcedureStep {
    
    func execute(with application: UIApplication)
    
}

public typealias BootstrappingProcedure = [BootstrappingProcedureStep]

public extension Collection where Element == BootstrappingProcedureStep {
    
    func execute(with application: UIApplication) {
        self.forEach { $0.execute(with: application) }
    }
    
}

#endif
