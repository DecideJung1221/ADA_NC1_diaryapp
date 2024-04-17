//
//  CustomDatePicker.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/15/24.
//
import SwiftUI

struct CustomDatePicker: View {
    
    @EnvironmentObject var store: MemoStore
    @Binding var currentDate: Date
    
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    
    var body: some View {
        NavigationView{
        VStack{
            
            //Days
            let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: 20 ){
                VStack(alignment: .leading,spacing: 10 ){
                    Text(extraData()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraData()[1])
                        .font(.title.bold())
                    
                }
                Spacer(minLength: 0)
                
                Button{
                    withAnimation{
                        currentMonth -= 1
                    }
                }
            label:{
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
                
                Button{
                    withAnimation{
                        currentMonth += 1
                    }
                }
            label:{
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
            }
            .padding(.horizontal)
            
            //Day view...
            HStack(spacing: 0){
                ForEach(days,id: \.self){day in
                    Text(day)
                    
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            //Dates...
            //LazyGrid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(extractDate()) {value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(.blue)
                                .padding(.horizontal,8)
                                
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 20){
                Text("내역")
                    .font(.title2.bold())
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.vertical,20 )
                ScrollView(.vertical,showsIndicators: false){
                    let tasks = store.tasks
                    if tasks.first(where: {task in
                        return isSameDay(date1: task.time, date2: currentDate)
                    }) != nil{
//                        NavigationView{
                            ForEach(tasks) {task in
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    if (isSameDay(date1: task.time, date2: currentDate)) {
                                        //                                    Text("\((task.title))")
                                        //                                        .font(.title2.bold())
                                        
                                        NavigationLink{
                                            DetailView(memo: task)
                                        }label:{
                                            MemoCell(memo: task)
                                        }
//                                        MemoCell(memo: task)
                                    }
                                }
                                //                            .padding(.vertical,1)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                //                            .background(Color(Color.customBackgroundsky)
                                //                                .opacity(0.3)
                                //                                .cornerRadius(10))
                            }
//                        }
                    }else{
                        Text("내역이 없습니다. ")
                    }
                }
            }
            .padding()
            .padding(.top,25)
        }
        .onChange(of: currentMonth){
            currentDate = getCurrentMonth()
        }
        }
    }
    @ViewBuilder
    func CardView(value: DateValue)-> some View{
        VStack{
            if value.day != -1{
                let tasks = store.tasks
                
                if let task = tasks.first(where: {task in
                    
                    return isSameDay(date1: task.time, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.time, date2: currentDate) ? .white : .primary )
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.time, date2: currentDate) ? .white : Color.customBackgroundsky)
                        .frame(width: 8,height: 8)
//                        .fill(Color("Pink"))
                }
                else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary )
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
//        Text("test")
        }
        .padding(.vertical,8)
        .frame(height: 60, alignment: .top)
        
    }
    //checking dates....
    func isSameDay(date1: Date, date2: Date)-> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1,inSameDayAs: date2)
    }
    
    
    func extraData() ->[String]{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
        
    }
    
    func getCurrentMonth()-> Date{
        let calendar = Calendar.current
        
        //Getting Current Month Date..
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else{
            return Date()
        }
        return currentMonth
    }
    
    
    func extractDate() -> [DateValue]{
        
        let calendar = Calendar.current
        
        //Getting Current Month Date..
        
        let currentMonth = getCurrentMonth()
                
        var days = currentMonth.getAllDates().compactMap{date ->
            DateValue in
            
            //getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
         
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
            
        }
        return days
    }
}

//Extending Date to get Current Month Dates...
extension Date{
    func getAllDates() -> [Date]{
        let calendar = Calendar.current
        
        //getting start date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for:
                                    startDate)!
        
        //getting date...
        return range.compactMap{day -> Date in
            return calendar.date(byAdding: .day, value: day -
                                 1 , to: startDate)!
        }
    }
}
