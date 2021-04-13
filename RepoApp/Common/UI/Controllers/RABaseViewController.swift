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

    /// `false` if you don't want view to add automatic scrolling, when editing.
     var isEnableScrollingWhileEditing: Bool = true

    /// Set `false` if you don't need scroll view bottom contentInset, when keyboard shows.
    /// - default: `true`
    var addScrollViewContentInsetForKeyboardDidShow: Bool = true

    private var scrollViewObserver: NSKeyValueObservation?

    // MARK: - keyboard
    var keyboardIsShown: Bool = false
    var isNewFirstResponder: Bool = true

    /// coincides with the height of the keyboard, when it is shown excluding bottom safeAreaInsets height. 0 when it is hidden.
    private(set) var keyboardBottomOffset: CGFloat = 0

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
    private(set) lazy var mainScrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.contentInset = UIEdgeInsets.zero
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never

        return view
    }()

    var heightMainViewConstraint: Constraint?

    private(set) lazy var mainView: RAView = {
        let view = RAView()
        view.backgroundColor = .white

        return view
    }()

    private(set) lazy var contentViewTapGestureRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleTapInContentView(_:)))
        tap.delegate = self

        return tap
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
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.addSubview(self.mainView)

        self.makeConstraints()
    }

    func initController() { }

    // MARK: - Constraints
    private func makeConstraints() {
        self.mainScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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

        self.registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.view.endEditing(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.deregisterFromKeyboardNotifications()
    }

    func singleWillAppear() {}

    func singleDidAppear() {}

    func secondDidAppear() {}

    // MARK: - keyboard notifications
    private func registerForKeyboardNotifications() -> Void {
        self.deregisterFromKeyboardNotifications()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    // MARK: - keyboard notification handling
    @objc func keyboardWillShow(_ notification: Notification) {
        self.contentViewTapGestureRecognizer(isActive: true)
        guard let userInfo = (notification as NSNotification).userInfo,
              let keyboardNSValue: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        var keyboardFrame: CGRect = keyboardNSValue.cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber ?? NSNumber(value: 0)).doubleValue

        self.keyboardBottomOffset = keyboardFrame.size.height - self.view.safeAreaInsets.bottom

        UIView.animate(
            withDuration: duration,
            animations: {
                if !self.isContentScrollingEnabled, self.isEnableScrollingWhileEditing {
                    self.heightMainViewConstraint?.deactivate()
                }
                self.mainScrollView.contentInset.bottom = self.keyboardBottomOffset

                self.keyboardWillShowAnimation()
                self.view.layoutIfNeeded()
            })
    }


    @objc func keyboardWillHide(_ notification: Notification) {
        self.contentViewTapGestureRecognizer(isActive: false)

        let info = (notification as NSNotification).userInfo!
        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber ?? NSNumber(value: 0))
            .doubleValue
        self.keyboardBottomOffset = 0.0
        if self.addScrollViewContentInsetForKeyboardDidShow {
            self.mainScrollView.contentInset.bottom = self.keyboardBottomOffset
        }

        // we activate mainView height to disable scrolling, if `self.isContentScrollingEnabled == false`
        if let heightConstraint = self.heightMainViewConstraint,
            !self.isContentScrollingEnabled,
            !heightConstraint.isActive {
            self.heightMainViewConstraint?.activate()
        }

        self.view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration, animations: {
            self.mainScrollView.contentInset.bottom = self.keyboardBottomOffset

            self.keyboardWillHideAnimation()
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - keyboard animations
    func keyboardWillShowAnimation() {}

    func keyboardWillHideAnimation() {}

    // MARK: - Content gesture recognizers
    func contentViewTapGestureRecognizer(isActive: Bool) {
        self.view.removeGestureRecognizer(self.contentViewTapGestureRecognizer)
        if isActive {
            self.view.addGestureRecognizer(self.contentViewTapGestureRecognizer)
        }
    }

    @objc func handleTapInContentView(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
}

extension RABaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer === self.contentViewTapGestureRecognizer {
            return true
        }
        return false
    }
}
