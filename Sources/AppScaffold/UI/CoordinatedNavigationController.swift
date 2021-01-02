//
//  CoordinatedNavigationController.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

#if canImport(UIKit)

import UIKit

public class CoordinatedNavigationController: UINavigationController {
    
    public weak var coordinator: Coordinator?
    
    public var menuItem: MenuItem? {
        
        didSet {
            
            guard let menuItem = menuItem else {
                tabBarItem = nil
                title = nil
                return
            }
            
            tabBarItem = UITabBarItem(title: menuItem.title,
                                      image: menuItem.image,
                                      selectedImage: nil)
            title = menuItem.title
            
        }
        
    }
    
}

#endif
