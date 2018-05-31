//
//  DepartureScheduleViewModel.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class StopScheduleViewModel: NSObject {

    var name : String
    var destination : String
    var remainingMinutesText : String!

    init(withStopSchedule stopSchedule: StopSchedule) {
        self.name = stopSchedule.name
        self.destination = stopSchedule.destination ?? "destination..."
        super.init()
        if stopSchedule.departures.count > 0 {
            self.remainingMinutesText = remaininTimeText(for: stopSchedule.departures[0].remainingMinutes)
        }
        else {
            self.remainingMinutesText = "remaining time..."
        }
    }

    private func remaininTimeText(for remainingMinutes: Int) -> String {
        if remainingMinutes > 60 {
            let hours : Int = remainingMinutes / 60
            let minutes : Int = remainingMinutes - (hours * 60)
            return String(format: "%d h : %d min.", hours, minutes)
        }
        else {
            return String(format: "%d min.", remainingMinutes)
        }
    }
}
