//
//  RABaseViewController.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import UIKit
import SnapKit

class RABaseViewController: UIViewController {
    // MARK: - Variables Life Cicle
    private(set) var isViewDidAppeared: Bool = false
    private(set) var isViewWillAppeared: Bool = false

    // MARK: - Scrolling
    /// `false` if you don't want view to add automatic scrolling, when content is greater than visible view area.
    var isContentScrollingEnabled: Bool = true

    // MARK: - NavigationBar
    var controllerTitle: String? {
        get {
            self.navigationItem.title
        }
        set {
            self.navigationItem.title = newValue
        }
    }

    // MARK: - GUI Variables
    private let backgroundColor = UIColor(named: "background")

    private(set) lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never

        return view
    }()

    var heightMainViewConstraint: Constraint?

    private(set) lazy var mainView: RAView = {
        let view = RAView()
        view.backgroundColor = self.backgroundColor

        return view
    }()

    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    required init() {
        super.init(nibName: nil, bundle: nil)
    }

    private func _initController() {
        self.view.backgroundColor = self.backgroundColor

        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.mainView)

        self.makeConstraints()
    }

    func initController() { }

    // MARK: - Constraints
    private func makeConstraints() {
        self.mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.bottom.equalToSuperview()
        }

        self.setContentScrolling(isEnabled: self.isContentScrollingEnabled)
    }

    /// enables or disables content scrolling.
    /// - parameters:
    ///   - isEnabled: `true` scroll is enabled, `false` content is fixed. Default is `true`
    func setContentScrolling(isEnabled: Bool) {
        self.isContentScrollingEnabled = isEnabled

        self.mainView.snp.remakeConstraints { (make) in
            make.edges.width.equalToSuperview()
            if !isEnabled {
                self.heightMainViewConstraint = make.height.equalTo(self.mainScrollView).constraint
            }
        }
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self._initController()
        self.initController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !self.isViewWillAppeared {
            self.isViewWillAppeared = true
            self.singleWillAppear()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.isViewDidAppeared {
            self.secondDidAppear()
        } else {
            self.isViewDidAppeared = true
            self.singleDidAppear()
        }
    }

    func singleWillAppear() {}

    func singleDidAppear() {}

    func secondDidAppear() {}
}
