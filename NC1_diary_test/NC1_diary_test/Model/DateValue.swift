//
//  DateValue.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/15/24.
//
import SwiftUI

//Date Value Model....
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
