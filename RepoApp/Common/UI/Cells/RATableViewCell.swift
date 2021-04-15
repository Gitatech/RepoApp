//
//  RATableViewCell.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit

class RATableViewCell: UITableViewCell {
    // MARK: - Identifiers
    static var identifier: String {
        Self.description()
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }

    // MARK: - Constraints
    override func updateConstraints() {
        self.constraints()
        super.updateConstraints()
    }

    func constraints() {}
}
