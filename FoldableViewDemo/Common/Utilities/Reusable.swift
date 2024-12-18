//
//  Reusable.swift
//  FoldableViewDemo
//
//  Created by 구지연 on 12/18/24.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

// MARK: - Default implementation

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
