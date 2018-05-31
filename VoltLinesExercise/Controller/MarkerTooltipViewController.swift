//
//  MarkerTooltipViewController.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 31.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import PullUpController

class MarkerTooltipViewController: PullUpController {

    private var markerTooltipViewAdded = false

    var markerTooltipView : MarkerTooltipView? {
        didSet {
            addMarkerTooltipView()
        }
    }

    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        return [0]
    }

    override var pullUpControllerPreviewOffset: CGFloat {
        if let previewOffset = markerTooltipView?.previewOffset {
            return previewOffset
        }
        else {
            return super.pullUpControllerPreviewOffset
        }
    }

    override func viewDidLoad() {
        addBlurEffect()
        addMarkerTooltipView()
    }

    func addBlurEffect() {
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = self.view.bounds
        bluredView.frame = self.view.bounds

        view.insertSubview(bluredView, at: 0)
    }

    func addMarkerTooltipView() {
        guard !markerTooltipViewAdded else {
            return
        }

        guard let markerTooltipView = markerTooltipView else {
            return
        }

        markerTooltipViewAdded = true

        view.addSubview(markerTooltipView)
        markerTooltipView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview()
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
        }
    }

    func reloadViewModel() {
        markerTooltipView?.reloadViewModel()
    }
}
