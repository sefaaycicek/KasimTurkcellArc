//
//  Date+Extension.swift
//  KasimTurkcellArc
//
//  Created by Sefa Aycicek on 7.11.2024.
//

import UIKit

extension Date {
    func toString(format : DateFormatterType = .yearMonthDay)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

extension String {
    func toDate(format : DateFormatterType = .yearMonthDay) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
}

enum DateFormatterType : String {
    case yearMonthDay = "yyyy-MM-dd"
    case dayMonthYear = "dd-MM-yyyy"
    case yearMonthDayTitle = "yyyy MMMM EEEE"
}
