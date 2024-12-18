//
//  SectionViewModel.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import Foundation

struct SectionViewModel: Hashable {
    let id = UUID()
    let title: String
    let date: String
    let count: Int
    var isOpen: Bool = false
    let cellViewModels: [CellViewModel]
}
