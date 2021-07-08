//
//  MenuItem.swift
//  
//
//  Created by Lennart Fischer on 02.01.21.
//

#if canImport(UIKit)

import UIKit

public struct MenuItem: Hashable, Identifiable {
    public let title: String?
    public let image: UIImage?
    public let id = UUID()
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
}

#endif

#if canImport(AppKit)
import AppKit

public struct MenuItem: Hashable, Identifiable {
    public let title: String?
    public let image: NSImage?
    public let id = UUID()
    
    public init(title: String?, image: NSImage?) {
        self.title = title
        self.image = image
    }
}

#endif
