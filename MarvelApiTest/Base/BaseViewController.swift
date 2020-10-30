//
//  BaseViewController.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxCocoa
import RxSwift
import UIKit

open class BaseViewController<VM: BaseViewModel>: UIViewController,
    StoryboardInitializable
{
    public var viewModel: VM!
    public var bag = DisposeBag()
    
    fileprivate var messageView: MessageLayer?

    public var moveViewAlongKeyboard = false
    private var kbHeight: CGFloat!

    public var isPopBySwipEnabled: Bool = true {
        didSet {
            navigationController?.interactivePopGestureRecognizer?
                .isEnabled = isPopBySwipEnabled
            self.navigationController?.navigationBar
                .isHidden = !isPopBySwipEnabled
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        bindViews()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // sometimes user dismiss viewcontroller by gusture and thus the coordinator will not getting free
        // so we need another mech to freeup coordinator
        if isMovingFromParent {
            viewModel.poppedFromNavigationStack.onNext(())
        }
    }

    /**
     Bind any view to model view observer like:
     ````
     (cancelBtn.rx.tap).bind(to: viewModel.cancel).disposed(by: bag)
     ````
     */
    open func bindViews() {
        preconditionFailure("This method must be overrited by child class")
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    /// Remove the view controller form navigation stack by delay
    ///
    /// - Parameter withDelay: delay to remove
    open func removeFormNavigationStack(withDelay _: DispatchTime = DispatchTime
        .now() + 1.5)
    {
        DispatchQueue.main
            .asyncAfter(deadline: DispatchTime.now() + 1.5) { [weak self] in
                guard let `self` = self else { return }

                guard let index = self.navigationController?.viewControllers
                    .firstIndex(where: {
                        $0.restorationIdentifier == self.restorationIdentifier
                    })
                else {
                    return
                }
                self.navigationController?.viewControllers.remove(at: index)
            }
    }

    deinit {
        Log.i("\(String(describing: restorationIdentifier))")
        viewModel.poppedFromNavigationStack.onNext(())
        bag = DisposeBag()
    }
}

extension BaseViewController {
    public func showMessage(msg: String,
                            messageType: MessageType) {
        let height = statusBarHeight() + MessageLayer.messageHeight
        messageView = MessageLayer(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: view.frame.width,
                                                 height: height))
        if let nav = navigationController {
            nav.view.addSubview(messageView!)
        } else {
            view.addSubview(messageView!)
        }
        messageView?.showMessage(msg, type: messageType, autoHide: true)
    }
    
    func statusBarHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}

extension BaseViewController {
    public var rx_showMessage: AnyObserver<(String, MessageType)> {
        return Binder(self, binding: { [weak self] _, data in
            let (msg, type) = data
            self?.showMessage(msg: msg, messageType: type)
        }).asObserver()
    }
}
