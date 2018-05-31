//
//  for schedule in schedulesAtStop {              } StopScheduleView.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class StopScheduleView: UIView {
    var stackView : UIStackView!
    var nameLabel : UILabel!
    var destinationLabel : UILabel!
    var remainingMinutesLabel : UILabel!

    var viewModel : StopScheduleViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            destinationLabel.text = viewModel?.destination
            remainingMinutesLabel.text = viewModel?.remainingMinutesText
        }
    }

    convenience init(parentFrame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: parentFrame.width, height: 50)
        self.init(frame: frame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView = UIStackView(frame: frame)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }

        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel.textAlignment = .left
        nameLabel.text = ""
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        stackView.addArrangedSubview(nameLabel)

        destinationLabel = UILabel(frame: CGRect.zero)
        destinationLabel.textAlignment = .center
        destinationLabel.setContentHuggingPriority(.defaultLow, for: UILayoutConstraintAxis.horizontal)
        destinationLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        destinationLabel.textColor = UIColor.gray
        destinationLabel.adjustsFontSizeToFitWidth = true
        destinationLabel.text = "destination..."
        stackView.addArrangedSubview(destinationLabel)

        remainingMinutesLabel = UILabel(frame: CGRect.zero)
        remainingMinutesLabel.textAlignment = .right
        remainingMinutesLabel.setContentHuggingPriority(.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        remainingMinutesLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        remainingMinutesLabel.textColor = UIColor.gray
        remainingMinutesLabel.adjustsFontSizeToFitWidth = true
        remainingMinutesLabel.text = "remaining time..."
        stackView.addArrangedSubview(remainingMinutesLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
