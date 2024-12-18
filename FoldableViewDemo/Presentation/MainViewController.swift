//
//  MainViewController.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import Combine
import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    private let mainViewModel = MainViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<SectionViewModel, CellViewModel>!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        mainViewModel.send(.viewDidLoad)
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        mainView.collectionView.delegate = self
        // 셀
        dataSource = UICollectionViewDiffableDataSource<SectionViewModel, CellViewModel>(
            collectionView: mainView.collectionView
        ) { collectionView, indexPath, cellViewModel in
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DetailCell.self)
            // 데이터 바인딩
            cell.configure(with: cellViewModel)
            return cell
        }
        // 헤더
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            let headerView = collectionView.dequeueReusableHeader(
                for: indexPath,
                viewType: HeaderView.self
            )
            // 데이터 바인딩
            let sectionViewModel = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            headerView.configure(with: sectionViewModel)
            // 탭 제스처 바인딩
            let tapGesture = UITapGestureRecognizer()
            headerView.addGestureRecognizer(tapGesture)
            tapGesture.tapPublisher
                .sink { [weak self] _ in
                    guard !sectionViewModel.cellViewModels.isEmpty else { return }
                    self?.generateHaptic()
                    self?.mainViewModel.send(.sectionDidTap(indexPath.section))
                }
                .store(in: &self.cancellables)
            return headerView
        }
    }
    
    private func setupBindings() {
        mainViewModel.state.sectionViewModels
            .sink { [weak self] sectionViewModels in
                self?.applySnapshot(with: sectionViewModels)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(with sectionViewModels: [SectionViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionViewModel, CellViewModel>()
        
        sectionViewModels.forEach { sectionViewModel in
            snapshot.appendSections([sectionViewModel])
            if sectionViewModel.isOpen {
                snapshot.appendItems(sectionViewModel.cellViewModels, toSection: sectionViewModel)
            } else {
                snapshot.appendItems([], toSection: sectionViewModel)
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 셀 크기
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 56)
    }
    
    // 헤더 크기
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 56)
    }
}
