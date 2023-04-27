//
//  Coordinator.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

import Foundation

#if canImport(UIKit) && os(iOS)

import UIKit

@available(iOS 14.0, *)
public protocol Coordinator: AnyObject {
    
    var navigationController: CoordinatedNavigationController { get set }
    
    func rootViewController() -> UIViewController
    
}

public extension Coordinator {
    
    func rootViewController() -> UIViewController {
        return navigationController
    }
    
}

#endif
