//
//  RAView.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RAView: UIView {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.initView()
    }

    init() {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {}

    // MARK: - constraints
    override func updateConstraints() {
        self.constraints()
        super.updateConstraints()
    }

    func constraints() {}
}
