//
//  CellViewModel.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import Foundation

struct CellViewModel: Hashable {
    let id = UUID()
    let timestamp: String
    let time: Int
}
