//
//  DiaryHome.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/15/24.
//

import SwiftUI
import Foundation

struct DiaryHome: View {
    @EnvironmentObject var store: MemoStore
    let calendar = Calendar.current
    
    //compose뷰를 사용할 때 이용
    @State private var showComposer: Bool = false
    @State var currentDate: Date = Date()
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    @State var moneyPlus: Int = 0
    @State var moneyminus: Int = 0
    
    let columns = [GridItem(.flexible())]
    let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
    
    
    var body: some View {
        
        NavigationView{
            VStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color.customBackgroundsky)
                        .frame(width: 350, height: 100)
                        .padding()
                    HStack{
                        Spacer()
                        HStack{
                            //                            var currentMonth = (Int(extraData()[0]))!
                            
                            
                            VStack(alignment: .center){
                                Text("\(extraData()[0])")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                Text("\(extraData()[1]) 월")
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                            VStack{
                                
                                Button{
                                    withAnimation{
                                        currentMonth += 1
                                    }
                                    print(currentMonth)
                                }label: {
                                    Image(systemName: "arrowtriangle.up.fill")
                                        .resizable()
                                        .frame(width: 10,height: 10)
                                }
                                
                                Button{
                                    withAnimation{
                                        currentMonth -= 1
                                    }
                                    print(currentMonth)
                                }label: {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .resizable()
                                        .frame(width: 10,height: 10)
                                }
                                
                            }
                            .onChange(of: currentMonth){
                                newValue in
                                //updating Month...
                                currentDate = getCurrentMonth()
                            }
                        }
                        Spacer()
                        
                        VStack{
                            
//                            Text("\(ArraySum(ar: monthDownMoney(month: (Int(extraData()[1]) ?? 4))))")
//                            Text("\(ArraySum(ar: monthUpMoney(month: (Int(extraData()[1]) ?? 4))))")
//                            Text("\(moneyminus)")
                            Text("수입: \(ArraySum(ar: monthUpMoney(month: (Int(extraData()[1]) ?? 4))))원")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            Text("지출: \(ArraySum(ar: monthDownMoney(month: (Int(extraData()[1]) ?? 4))))원")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            
                        }
                        .padding()
                        Spacer()
                    }
                    .frame(width: 350, height: 100)
                    .padding()
                }
                
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        
                        ForEach(store.tasks) { memo in
                            VStack{
                                NavigationLink{
                                    DetailView(memo: memo)
                                }label:{
                                    MemoCell(memo: memo)
                                }
                                
                            }
                            .frame(width: 350, height: 100)
                            //                              .foregroundColor(color)
                        }
                    }
                    .padding()
                }
            }
            .listStyle(.plain)
            .navigationTitle("내역")
            .toolbar{
                Button{
                    showComposer = true
                }label: {
                    Image(systemName: "plus")
                }
            }
            //새로운 메모를 모달로 표시!
            .sheet(isPresented: $showComposer, content: {
                ComposeView()
            })
            
            
        }
        
        
        
    }
    //    func max() -> Int{
    //        ForEach(store.tasks,id: \.self) { memo in
    //            var components = calendar.dateComponents([.year, .month, .day],from: (memo.time))
    //
    //            if (Int(extraData()[1]) ?? 4) == (Int((components.month)!)) {
    //                if memo.money <= 0 {
    //                    Text("낮음\(memo.money)")
    //    //                                        moneyminus += (memo.money)
    //    //                                        moneyminus += 1
    //
    //                }else{
    //    //                                        moneyPlus += moneyPlus
    //
    //                    Text("높음\(memo.money)")
    //                }
    //    //                                    Text("같음")
    //            }
    //        }
    //
    //    }
    //
    
    func ArraySum(ar: [Int]) -> Int{
        return ar.reduce(0, +)
    }
    
    func extraData() ->[String]{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MM"
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
    
    
    func monthDownMoney(month: Int) -> [Int]{
        var test: [Int] = []
        //        var a : [String] = []
        //                                for i in spel{
        //                                    a.append(String(i))
        //                                }
        //        store
        
        
        for memo in store.tasks{
            var components = calendar.dateComponents([.year, .month, .day],from: (memo.time))
            if (month) == (Int((components.month)!)) {
                if memo.money <= 0 {
                    
                    test.append((Int((memo.money))) )
                    //            print(1)
                }
            }
        };return test
    }
    
    
    func monthUpMoney(month: Int) -> [Int]{
        var test: [Int] = []
        //        var a : [String] = []
        //                                for i in spel{
        //                                    a.append(String(i))
        //                                }
        //        store
        
        
        for memo in store.tasks{
            var components = calendar.dateComponents([.year, .month, .day],from: (memo.time))
            if (month) == (Int((components.month)!)) {
                if memo.money >= 0 {
                    
                    test.append((Int((memo.money))) )
                    //            print(1)
                }
            }
        };return test
    }
}
    
//        memo?.$time
//        var components = calendar.dateComponents([.year, .month, .day],from: (memo?.$time ?? Date()))
//        for _ in 0..<firstWeekday - 1{
//            days.insert(DateValue(day: -1, date: Date()), at: 0)
//            
//        }
//        }
        // adding offset days to get exact week day...
//        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
//        
//        for _ in 0..<firstWeekday - 1{
//            days.insert(DateValue(day: -1, date: Date()), at: 0)
//            
//        }
//        return days
    
//}
