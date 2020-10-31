//
//  MessageLayer.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import UIKit

public enum MessageType: Int {
    case message
    case error
}

private enum SwipeDirection {
    case left
    case right
    case top
    case none
}

public class MessageLayer: UIView {
    @IBOutlet var messageTitle: UILabel!
    @IBOutlet var messageBox: UIView!

    var type: MessageType = .message

    var frameStartX: CGFloat = 16
    var frameStartY: CGFloat = 24
    let velocityThreshold = 0

    static let messageHeight: CGFloat = 50.0

    public override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        // TODO: do i need all initializer????
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        addGesture()
        loadNib()

        frameStartX = frame.origin.x
        frameStartY = frame.origin.y
    }

    func loadNib() {
        let xibView = Bundle(for: MessageLayer.self)
            .loadNibNamed("MessageLayer", owner: self, options: nil)!
            .first as! UIView

        xibView.frame = bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
}

extension MessageLayer {
    func addGesture() {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(panGesture(recognizer:)))
        addGestureRecognizer(gesture)
    }

    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let yLocation = recognizer.location(in: superview!).y
        let direction = recognizer.direction ?? .down

        // allow the view to be scrolled until translation has not exceeded its height
        if (yLocation < frame.midY) || direction == .up {
            let y = frame.minY
            frame = CGRect(x: frame.origin.x,
                           y: y + translation.y,
                           width: frame.width,
                           height: frame.height)
            recognizer.setTranslation(CGPoint(), in: self)
        }

        let lastVelocity = recognizer.velocity(in: self)
        if recognizer.state == .ended {
            handleEndSwipe(xVelocity: Int(abs(lastVelocity.x)))
        }
    }
}

extension MessageLayer {
    func handleEndSwipe(xVelocity: Int) {
        if xVelocity < velocityThreshold {
            handleHiddenStatus(.none)
            return
        }

        handleHiddenStatus(.top)
        //        if self.frame.origin.x < frameStartX {
        //            // swiped to left
        //            handleHiddenStatus(.left)
        //        } else {
        //            // swiped to right
        //            handleHiddenStatus(.right)
        //        }
    }

    private func handleHiddenStatus(
        _ direction: SwipeDirection,
        withDelay: TimeInterval = 0.0
    ) {
        var frame = self.frame
        var hidden = false

        switch direction {
        case .none:
            frame.origin.x = frameStartX
            hidden = false
        case .left:
            frame.origin.x = -1 * (frame.size.width + 100)
            hidden = true
        case .right:
            frame.origin.x = frame.size.width + 100
            hidden = true
        case .top:
            frame.origin.y = -frame.size.height
            hidden = true
        }

        animateToFrame(frame, hidden: hidden, withDelay: withDelay)
    }

    private func animateToFrame(
        _ frame: CGRect,
        hidden: Bool,
        withDelay: TimeInterval
    ) {
        UIView.animate(withDuration: 0.5,
                       delay: withDelay,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                           self?.frame = frame
        }) { [weak self] completed in
            if completed {
                self?.isHidden = hidden
                if let x = self?.frameStartX {
                    self?.frame.origin.x = x
                }
                if hidden {
                    self?.removeFromSuperview()
                }
            }
        }
    }
}

extension MessageLayer {
    public func showAutoHideMessage(_ title: String, type: MessageType) {
        showMessage(title, type: type, autoHide: true)
    }

    public func showMessage(
        _ title: String,
        type: MessageType,
        autoHide: Bool = true
    ) {
        messageTitle.text = title
        self.type = type

        switch type {
        case .message:
            messageBox.backgroundColor = UIColor.cyan
        case .error:
            messageBox
                .backgroundColor = UIColor(red: 1.0, green: 77 / 255,
                                           blue: 77 / 255, alpha: 1.0)
        }

        animateIn(autoHide)
    }

    public func showMessage(autoHide: Bool = true) {
        animateIn(autoHide)
    }
}

extension MessageLayer {
    private func animateIn(_ autoHide: Bool) {
        frame.origin.y = -frame.size.height

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                           self.frame.origin.y = 0
        }) { completed in
            if completed, autoHide {
                self.animateOut(3.0)
            }
        }
    }

    private func animateOut(_ withDelay: TimeInterval = 0.0) {
        handleHiddenStatus(.top, withDelay: withDelay)
    }
}
