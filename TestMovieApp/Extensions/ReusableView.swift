//
//  ReusableView.swift
//  TestMovieApp
//
//  Created by Иван on 31.08.2018.
//  Copyright © 2018 Иван. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var nibName: String { get }
    static var identifier: String { get }
}

extension Reusable where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(self)
    }
  
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

