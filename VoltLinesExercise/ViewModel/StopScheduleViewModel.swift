//
//  DepartureScheduleViewModel.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class StopScheduleViewModel: NSObject {

    private var stopSchedule : StopSchedule?

    var name : String
    var destination : String
    var remainingMinutesText : String!
    var remainingMinutes : Int? {
        return self.stopSchedule?.remainingMinutes
    }

    init(stopSchedule: StopSchedule) {
        self.stopSchedule  = stopSchedule
        self.name = stopSchedule.name
        self.destination = stopSchedule.destination ?? "destination..."
        super.init()
        if let remainingMinutes = self.remainingMinutes {
            self.remainingMinutesText = remainingTimeText(for: remainingMinutes)
        }
        else {
            self.remainingMinutesText = "remaining time..."
        }
    }

    func reload(stopSchedule: StopSchedule) -> Bool {
        self.name = stopSchedule.name
        self.destination = stopSchedule.destination ?? ""
        if stopSchedule.departures.count > 0 {
            self.remainingMinutesText = remainingTimeText(for: stopSchedule.departures[0].remainingMinutes)
        }
        else {
            return false
        }
        return true
    }

    private func remainingTimeText(for remainingMinutes: Int) -> String {
        if remainingMinutes > 60 {
            let hours : Int = remainingMinutes / 60
            let minutes : Int = remainingMinutes - (hours * 60)
            if minutes > 1 {
                return String(format: "%d h : %d mins.", hours, minutes)
            }
            else {
                return String(format: "%d h : %d min.", hours, minutes)
            }
        }
        else if remainingMinutes > 1 {
            return String(format: "%d mins.", remainingMinutes)
        }
        else {
            return String(format: "%d min.", remainingMinutes)
        }
    }
}
