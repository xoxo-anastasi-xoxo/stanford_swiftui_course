//
//  ElapsedTime.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI

struct ElapsedTimeView: View {
    let startTime: Date?
    let elapsedTime: TimeInterval
    
    var body: some View {
        if let startTime {
            Text(
                TimeDataSource<Date>.currentDate,
                format: .offset(to: startTime - elapsedTime, allowedFields: [.minute, .second])
            )
        } else {
            Text(Duration.seconds(elapsedTime), format: .time(pattern: .minuteSecond))
        }
    }
}
