//
//  MainView.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import UIKit

import SnapKit

final class MainView: UIView {
    // MARK: - Components
    
    private lazy var upperLine = createLine()
    
    private lazy var underLine = createLine()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 35
        stackView.distribution = .fill
        return stackView
    }()
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerCell(cellType: DetailCell.self)
        collectionView.registerHeader(viewType: HeaderView.self)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(upperLine)
        upperLine.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(upperLine.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(35)
            make.height.equalTo(36)
        }
        
        [createLabel(with: "회기"),
         createLabel(with: "최근 수행 일자"),
         createLabel(with: "수행 횟수")].forEach {
            stackView.addArrangedSubview($0)
        }
        
        addSubview(underLine)
        underLine.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

private extension MainView {
    func createLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }
    
    func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }
}
