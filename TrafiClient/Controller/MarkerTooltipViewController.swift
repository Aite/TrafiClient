//
//  MarkerTooltipViewController.swift
//  TrafiClient
//
//  Created by Alaa Al-Zaibak on 31.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import PullUpController

class MarkerTooltipViewController: PullUpController {

    private var markerTooltipViewAdded = false
    private var currentRegionName = ""

    var markerTooltipView : MarkerTooltipView? {
        didSet {
            addMarkerTooltipView()
        }
    }

    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        // return sticky point at 0 for closing pull up controller.
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

    func initialize(viewFrame frame: CGRect, viewModel: MarkerTooltipViewModel, regionName: String) {
        currentRegionName = regionName
        markerTooltipView = MarkerTooltipView(frame: frame)
        markerTooltipView?.viewModel = viewModel
        loadStopSchedules()
    }

    override func viewDidLoad() {
        addBlurEffect()
        addMarkerTooltipView()
    }

    private func addBlurEffect() {
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = self.view.bounds
        bluredView.frame = self.view.bounds

        view.insertSubview(bluredView, at: 0)
    }

    private func addMarkerTooltipView() {
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

    /* Loads stop schedules using TrafiAPIManager, and set them in the marker tooltip view.
     */
    private func loadStopSchedules() {

        guard let stop = markerTooltipView?.viewModel?.stop else {
            return
        }

        var regionName = currentRegionName.lowercased()
        let regionNameComponents = regionName.components(separatedBy: " ")
        if regionNameComponents.count > 0 {
            regionName = regionNameComponents[0]
        }

        TrafiAPIManager.default.retreiveStopDepartures(for: stop, region: regionName) { (success, error) in
            guard success || error == nil else {
                // Show an alert to the user if an error occurred
                let alert = UIAlertController(title: "Error!", message: "Can't connect to the server, please try again later!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            self.markerTooltipView?.viewModel?.reload(stopTooltip: stop.tooltip)
            self.markerTooltipView?.reloadViewModel()
        }
    }
}
