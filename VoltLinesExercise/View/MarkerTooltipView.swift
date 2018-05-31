//
//  MarkerTooltipView.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class MarkerTooltipView: UIView {

    var nameLabel : UILabel!
    var directionLabel : UILabel!
    var schedulesStackView : UIStackView!
    var mainScrolView : UIScrollView!

    var viewModel : MarkerTooltipViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            directionLabel.text = viewModel?.directionText
            if let schedulesAtStop = viewModel?.schedulesAtStop {
                for schedule in schedulesAtStop {
                    let stopScheduleView = StopScheduleView(parentFrame: self.frame)
                    stopScheduleView.viewModel = schedule
                    schedulesStackView.addArrangedSubview(stopScheduleView)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width, height: 20)))
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview()
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }
        
        directionLabel = UILabel(frame: CGRect(x: 0, y: 20, width: frame.width, height: 20))
        directionLabel.textAlignment = .center
        directionLabel.adjustsFontSizeToFitWidth = true
        addSubview(directionLabel)
        directionLabel.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalTo(nameLabel.snp.bottom).offset(10)
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }

        mainScrolView = UIScrollView(frame: CGRect(x: 0, y: 20, width: frame.width, height: frame.height - 40))
        addSubview(mainScrolView)
        mainScrolView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalTo(directionLabel.snp.bottom).offset(10)
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
            constraintMaker.width.equalTo(frame.width)
        }

        schedulesStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 40))
        schedulesStackView.axis = .vertical
        schedulesStackView.distribution = .fillEqually
        schedulesStackView.alignment = .fill
        schedulesStackView.spacing = 5

        mainScrolView.addSubview(schedulesStackView)
        schedulesStackView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview()
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
            constraintMaker.width.equalTo(frame.width)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
