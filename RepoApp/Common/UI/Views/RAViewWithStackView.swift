//
//  RAViewWithStackView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit
import SnapKit

class RAViewWithStackView: RAView {
    // MARK: - Variables
    var edgeInsets: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }

    var arrangedSubviews: [UIView] {
        get {
            return self.stackView.arrangedSubviews
        }
    }

    // MARK: - GUI variables
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 0
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - Initialisation
    override func initView() {
        super.initView()

        self.addSubview(self.stackView)
    }

    // MARK: - Constraints
    override func constraints() {
        super.constraints()

        self.stackView.snp.updateConstraints { maker in
            maker.edges.equalToSuperview().inset(self.edgeInsets)
        }
    }

    // MARK: - Setter
    func add(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }

    func add(_ views: [UIView]) {
        views.forEach { self.stackView.addArrangedSubview($0) }
    }

    func clearStackView() {
        self.stackView.removeAllArrangedSubviews()
    }

    func removeLastFromStackView() {
        self.stackView.arrangedSubviews.last?.removeFromSuperview()
    }
}

