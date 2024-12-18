//
//  DetailCell.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import UIKit

import SnapKit

final class DetailCell: UICollectionViewCell {
    static let reuseIdentifier = "DetailCell"
    
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var timestampLabel = createLabel()
    
    private lazy var timeLabel = createLabel()
    
    private let detailContainer = {
        let view = UIView()
        view.backgroundColor = .systemPink.withAlphaComponent(0.7)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let detailLabel = {
        let label = UILabel()
        label.text = "상세"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.5)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(35)
        }
        
        [timestampLabel, timeLabel, detailContainer].forEach {
            stackView.addArrangedSubview($0)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.width.equalTo(110)
        }
        
        detailContainer.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(35)
        }
        
        detailContainer.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with viewModel: CellViewModel) {
        timestampLabel.text = viewModel.timestamp
        timeLabel.text = "\(viewModel.time)분"
    }
}

private extension DetailCell {
    func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }
}
