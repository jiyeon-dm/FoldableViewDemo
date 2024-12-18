//
//  HapticFeedbackable.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/18/24.
//

import UIKit

protocol HapticFeedbackable {
    func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

extension HapticFeedbackable {
    func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
