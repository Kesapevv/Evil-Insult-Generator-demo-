//
//  Timer.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 15.05.2022.
//

import Foundation

protocol CountdownTimerProtocol {
    func stopCountdown()
    func startCountdown(totalTime: Int, timerEnded: @escaping () -> Void, timerInProgress: @escaping (Int) -> Void)
}

final class CountdownTimer: NSObject, CountdownTimerProtocol {
    private var timeRemaining = 0
    static var timer = Timer()
    var timerEndedCallback: (() -> Void)?
    var timerInProgressCallback: ((Int) -> Void)?
        
    deinit {
        stopCountdown()
    }
    
    func stopCountdown() {
        CountdownTimer.timer.invalidate()
    }
    
    func startCountdown(totalTime: Int, timerEnded: @escaping () -> Void, timerInProgress: @escaping (Int) -> Void) {
        timeRemaining = totalTime
        CountdownTimer.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        timerEndedCallback = timerEnded
        timerInProgressCallback = timerInProgress
    }
    
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            timerInProgressCallback?(timeRemaining)
        } else {
            stopCountdown()
            timerEndedCallback?()
        }
    }
}
