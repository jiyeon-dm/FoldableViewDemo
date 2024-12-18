//
//  HeaderView.swift
//  FoldableTableViewDemo
//
//  Created by 구지연 on 12/17/24.
//

import UIKit

import SnapKit

final class HeaderView: UICollectionReusableView {
    static let reuseIdentifier = "HeaderView"
    
    // MARK: - Components
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var titleLabel = createLabel()
    
    private lazy var dateLabel = createLabel()
    
    private let countButton = {
        let button = UIButton()
        button.tintColor = .black
        button.backgroundColor = .clear
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = .init(pointSize: 11.0, weight: .bold)
        config.image = UIImage(systemName: "chevron.up")
        config.imagePlacement = .trailing
        config.imagePadding = 5
        config.contentInsets = .zero
        button.configuration = config
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
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
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(35)
        }
        
        [titleLabel, dateLabel, countButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(110)
        }
        
        countButton.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Configure Methods
    
    func configure(with viewModel: SectionViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        let attributedTitle = NSAttributedString(
            string: "\(viewModel.count)회",
            attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .bold)]
        )
        countButton.setAttributedTitle(attributedTitle, for: .normal)
        countButton.configuration?.image = viewModel.isOpen ?
        UIImage(systemName: "chevron.up") :
        UIImage(systemName: "chevron.down")
        countButton.isEnabled = !viewModel.cellViewModels.isEmpty
    }
}

private extension HeaderView {
    func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }
}
