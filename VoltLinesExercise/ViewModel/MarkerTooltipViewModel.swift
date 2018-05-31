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

    func reload(withStopTooltip tooltip: StopTooltip) {
        self.name = tooltip.name
        self.directionText = tooltip.directionText ?? ""
        self.distanceText = tooltip.distanceText ?? ""
        for stopSchedule in tooltip.schedules {
            var stopScheduleFound = false
            for stopScheduleViewModel in self.schedulesAtStop {
                if stopScheduleViewModel.name == stopSchedule.name {
                    if !stopScheduleViewModel.reload(withStopSchedule: stopSchedule) {
                        if let indexToRemove = self.schedulesAtStop.index(of: stopScheduleViewModel) {
                            self.schedulesAtStop.remove(at: indexToRemove)
                        }
                    }
                    stopScheduleFound = true
                    break
                }
            }

            if !stopScheduleFound {
                let stopScheduleViewModel = StopScheduleViewModel(withStopSchedule: stopSchedule)
                self.schedulesAtStop.append(stopScheduleViewModel)
            }
        }
        self.schedulesAtStop.sort { (stopScheduleViewModel1, stopScheduleViewModel2) -> Bool in
            return (stopScheduleViewModel1.remainingMinutes ?? Int.max) < (stopScheduleViewModel2.remainingMinutes ?? Int.max)
        }
    }
}
