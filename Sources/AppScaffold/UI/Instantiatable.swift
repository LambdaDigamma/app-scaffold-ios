//
//  Instantiatable.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

#if canImport(UIKit) && os(iOS)

import UIKit

@available(iOS 14.0, *)
protocol Instantiatable {
    static func instantiate() -> Self
}

@available(iOS 14.0, *)
extension Instantiatable where Self: UIViewController {
    
    internal static func instantiate() -> Self {
        
        let newViewController = Self()
        
        return newViewController
        
    }
    
    internal static func instantiateFromStoryboard() -> Self {
        
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
        
    }
    
}

#endif
