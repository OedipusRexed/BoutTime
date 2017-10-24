//
//  TimerHelper.swift
//  Bout Time
//
//  Created by Aaron Revalee on 10/20/17.
//  Copyright © 2017 OedipusRexed. All rights reserved.
//

import Foundation


var timer = Timer()
var seconds = 60

var isTimerRunning = false

func timeString(time: TimeInterval) -> String {
    return String(format:"%02i.%01i", Int(seconds))
}







