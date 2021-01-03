//
//  ApplicationController.swift
//  
//
//  Created by Lennart Fischer on 03.01.21.
//

#if canImport(UIKit)

import UIKit

public protocol ApplicationControlling {
    
    var firstLaunch: FirstLaunch { get set }
    var config: AppConfigurable { get set }
    
    func rootViewController() -> UIViewController
    
}

extension ApplicationControlling {
    
    func rootViewController() -> UIViewController {
        
        return UIViewController()
        
    }
    
}

#endif
