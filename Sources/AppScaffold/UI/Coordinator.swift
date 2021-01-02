//
//  Coordinator.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

import Foundation

#if canImport(UIKit)

public protocol Coordinator: AnyObject {
    
    var navigationController: CoordinatedNavigationController { get set }
    
}

#endif
