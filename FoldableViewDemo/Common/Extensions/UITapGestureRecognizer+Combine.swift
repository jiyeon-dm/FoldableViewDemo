//
//  UITapGestureRecognizer+Combine.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/18/24.
//

import Combine
import UIKit

extension UITapGestureRecognizer {
    public var tapPublisher: AnyPublisher<UITapGestureRecognizer, Never> {
        gesturePublisher(for: self)
    }
}

private func gesturePublisher<Gesture: UIGestureRecognizer>(
    for gesture: Gesture
) -> AnyPublisher<Gesture, Never> {
    Publishers.ControlTarget(
        control: gesture,
        addTargetAction: { gesture, target, action in
            gesture.addTarget(target, action: action)
        },
        removeTargetAction: { gesture, target, action in
            gesture?.removeTarget(target, action: action)
        })
    .subscribe(on: DispatchQueue.main)
    .map { gesture }
    .eraseToAnyPublisher()
}
