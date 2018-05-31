//
//  MarkerTooltipViewModel.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class MarkerTooltipViewModel: NSObject {
    var stop : Stop
    var name : String
    var directionText : String
    var distanceText : String
    var schedulesAtStop = [StopScheduleViewModel]()

    init(stop: Stop) {
        self.stop = stop
        let stopTooltip = stop.tooltip
        self.name = stopTooltip.name
        self.directionText = stopTooltip.directionText ?? ""
        self.distanceText = stopTooltip.distanceText ?? ""
        for stopSchedule in stopTooltip.schedules {
            let stopScheduleViewModel = StopScheduleViewModel(stopSchedule: stopSchedule)
            self.schedulesAtStop.append(stopScheduleViewModel)
        }
    }

    func reload(stopTooltip: StopTooltip) {
        self.name = stopTooltip.name
        self.directionText = stopTooltip.directionText ?? ""
        self.distanceText = stopTooltip.distanceText ?? ""
        for stopSchedule in stopTooltip.schedules {
            var stopScheduleFound = false
            for stopScheduleViewModel in self.schedulesAtStop {
                if stopScheduleViewModel.name == stopSchedule.name {
                    if !stopScheduleViewModel.reload(stopSchedule: stopSchedule) {
                        if let indexToRemove = self.schedulesAtStop.index(of: stopScheduleViewModel) {
                            self.schedulesAtStop.remove(at: indexToRemove)
                        }
                    }
                    stopScheduleFound = true
                    break
                }
            }

            if !stopScheduleFound {
                let stopScheduleViewModel = StopScheduleViewModel(stopSchedule: stopSchedule)
                self.schedulesAtStop.append(stopScheduleViewModel)
            }
        }
        self.schedulesAtStop.sort { (stopScheduleViewModel1, stopScheduleViewModel2) -> Bool in
            return (stopScheduleViewModel1.remainingMinutes ?? Int.max) < (stopScheduleViewModel2.remainingMinutes ?? Int.max)
        }
    }
}
