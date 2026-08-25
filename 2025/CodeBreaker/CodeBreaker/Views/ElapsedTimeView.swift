//
//  ElapsedTime.swift
//  CodeBreaker
//
//  Created by Anastasiia Kazantseva on 25/08/2026.
//
import SwiftUI

struct ElapsedTimeView: View {
    let startTime: Date
    let endTime: Date?
    
    var body: some View {
        if let endTime {
            Text(
                endTime,
                format: .offset(
                    to: startTime,
                    allowedFields: [.minute, .second]
                )
            )
        } else {
            Text(
                TimeDataSource<Date>.currentDate,
                format: .offset(
                    to: startTime,
                    allowedFields: [.minute, .second]
                )
            )
        }
    }
}
