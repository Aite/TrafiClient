//
//  MarkerTooltipView.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class MarkerTooltipView: UIView {
    private let gripViewHeight = CGFloat(5)
    private let gripViewTopOffset = CGFloat(8)
    private let gripViewBottomOffset = CGFloat(7)

    private var gripView : UIView!
    private var nameLabel : UILabel!
    private var directionLabel : UILabel!
    private var schedulesStackView : UIStackView!
    private var mainScrolView : UIScrollView!

    var previewOffset : CGFloat {
        var offset = gripViewHeight + gripViewTopOffset + nameLabel.frame.height + 10
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            offset += 20
        }
        if directionLabel.text != "" {
            offset += directionLabel.frame.height + 10
        }
        return offset
    }

    var viewModel : MarkerTooltipViewModel? {
        didSet {
            if let viewModel = viewModel {
                nameLabel.text = viewModel.name
                directionLabel.text = viewModel.directionText

                for schedule in viewModel.schedulesAtStop {
                    let stopScheduleView = StopScheduleView(parentFrame: self.frame)
                    stopScheduleView.viewModel = schedule
                    schedulesStackView.addArrangedSubview(stopScheduleView)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addGripView()

        nameLabel = UILabel.init()
        nameLabel.frame.size.height = 20
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalTo(gripView.snp.bottom).offset(self.gripViewBottomOffset)
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }
        
        directionLabel = UILabel.init()
        directionLabel.frame.size.height = 20
        directionLabel.textAlignment = .center
        directionLabel.adjustsFontSizeToFitWidth = true
        addSubview(directionLabel)
        directionLabel.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalTo(nameLabel.snp.bottom).offset(10)
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }

        mainScrolView = UIScrollView.init()
        mainScrolView.frame.size.width = frame.width
        addSubview(mainScrolView)
        mainScrolView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalTo(directionLabel.snp.bottom).offset(10)
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
            constraintMaker.width.equalTo(frame.width)
        }

        schedulesStackView = UIStackView.init()
        schedulesStackView.frame.size.width = frame.width
        schedulesStackView.axis = .vertical
        schedulesStackView.distribution = .fillEqually
        schedulesStackView.alignment = .fill
        schedulesStackView.spacing = 5

        mainScrolView.addSubview(schedulesStackView)
        schedulesStackView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview()
            constraintMaker.leading.equalToSuperview().offset(10)
            constraintMaker.trailing.equalToSuperview().offset(10)
            constraintMaker.bottom.equalToSuperview()
            constraintMaker.width.equalTo(frame.width - 20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func addGripView() {
        gripView = UIView.init()
        gripView.backgroundColor = UIColor(white: 0, alpha: 0.14)
        gripView.layer.cornerRadius = 4

        addSubview(gripView)
        gripView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview().offset(self.gripViewTopOffset)
            constraintMaker.centerX.equalToSuperview()
            constraintMaker.width.equalTo(40)
            constraintMaker.height.equalTo(self.gripViewHeight)
        }
    }

    func reloadViewModel() {
        if let viewModel = viewModel {
            nameLabel.text = viewModel.name
            directionLabel.text = viewModel.directionText

            for arrangedSubview in schedulesStackView.arrangedSubviews {
                schedulesStackView.removeArrangedSubview(arrangedSubview)
            }

            for schedule in viewModel.schedulesAtStop {
                let stopScheduleView = StopScheduleView(parentFrame: self.frame)
                stopScheduleView.viewModel = schedule
                schedulesStackView.addArrangedSubview(stopScheduleView)
            }
        }
    }
}
