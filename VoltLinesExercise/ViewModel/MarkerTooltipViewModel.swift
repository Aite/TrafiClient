//
//  MarkerTooltipViewModel.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class MarkerTooltipViewModel: NSObject {
    var name : String
    var directionText : String
    var distanceText : String
    var schedulesAtStop = [StopScheduleViewModel]()

    init(withStopTooltip tooltip: StopTooltip) {
        self.name = tooltip.name
        self.directionText = tooltip.directionText ?? ""
        self.distanceText = tooltip.distanceText ?? ""
        for stopSchedule in tooltip.schedules {
            let stopScheduleViewModel = StopScheduleViewModel(withStopSchedule: stopSchedule)
            self.schedulesAtStop.append(stopScheduleViewModel)
        }
    }
}
