//
//  CalendarHome.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/15/24.
//

import SwiftUI

struct Home: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        
            VStack(spacing: 20){
                CustomDatePicker(currentDate: $currentDate)
            }
        
        .padding(.vertical)
    }
}

#Preview {
    Home()
}
