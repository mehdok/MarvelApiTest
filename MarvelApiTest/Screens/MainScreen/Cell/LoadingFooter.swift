//
//  LoadingFooter.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import UIKit
import RxSwift

class LoadingFooter: UIView {
    @IBOutlet var loadIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    
    var bag = DisposeBag()
    
    deinit {
        bag = DisposeBag()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main
            .loadNibNamed("LoadingFooter", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
