//
//  MainViewModel.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import Combine
import Foundation

final class MainViewModel {
    enum Action {
        case viewDidLoad
        case sectionDidTap(Int)
    }
    
    struct State {
        var sectionViewModels = CurrentValueSubject<[SectionViewModel], Never>([])
    }
    
    // MARK: - Properties
    
    private var actionSubject = PassthroughSubject<Action, Never>()
    private var cancellables = Set<AnyCancellable>()
    var state = State()
    
    // MARK: - Init
    
    init() {
        actionSubject.sink { [weak self] action in
            self?.handleAction(action)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            updateCollectionViewData()
        case .sectionDidTap(let index):
            toggleSectionOpenState(at: index)
        }
    }
    
    private func updateCollectionViewData() {
        let sectionViewModels = [
            SectionViewModel(
                title: "1회기.1회기 이름",
                date: "2024.03.06",
                count: 3,
                cellViewModels: [
                    CellViewModel(timestamp: "2024.03.06 18:34", time: 15),
                    CellViewModel(timestamp: "2024.03.02 12:20", time: 15),
                    CellViewModel(timestamp: "2024.02.28 08:14", time: 15)
                ]
            ),
            SectionViewModel(
                title: "2회기.2회기 이름",
                date: "2024.03.10",
                count: 9,
                cellViewModels: [
                    CellViewModel(timestamp: "2024.03.06 18:34", time: 9),
                    CellViewModel(timestamp: "2024.03.02 12:20", time: 9),
                    CellViewModel(timestamp: "2024.02.28 08:14", time: 9),
                    CellViewModel(timestamp: "2024.03.06 18:34", time: 9),
                    CellViewModel(timestamp: "2024.03.02 12:20", time: 9),
                    CellViewModel(timestamp: "2024.02.28 08:14", time: 9),
                    CellViewModel(timestamp: "2024.03.06 18:34", time: 9),
                    CellViewModel(timestamp: "2024.03.02 12:20", time: 9),
                    CellViewModel(timestamp: "2024.02.28 08:14", time: 9)
                ]
            ),
            SectionViewModel(
                title: "3회기.3회기 이름",
                date: "2024.03.16",
                count: 1,
                cellViewModels: [
                    CellViewModel(timestamp: "2024.03.06 18:34", time: 6)
                ]
            ),
            SectionViewModel(
                title: "4회기.4회기 이름",
                date: "-",
                count: 0,
                cellViewModels: []
            )
        ]
        state.sectionViewModels.send(sectionViewModels)
    }
    
    private func toggleSectionOpenState(at index: Int) {
        var sectionViewModels = state.sectionViewModels.value
        if sectionViewModels[index].cellViewModels.isEmpty { return }
        sectionViewModels[index].isOpen.toggle()
        state.sectionViewModels.send(sectionViewModels)
    }
    
    func send(_ action: Action) {
        actionSubject.send(action)
    }
}
