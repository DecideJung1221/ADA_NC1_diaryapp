//
//  DiaryHome.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/15/24.
//

import SwiftUI

struct DiaryHome: View {
    @EnvironmentObject var store: MemoStore
    
    //compose뷰를 사용할 때 이용
    @State private var showComposer: Bool = false
    @State var currentDate: Date = Date()
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    
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
                            
                            
                            Text("\(extraData()[1]) 월")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
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
                            Text("수입: 1,000,000원")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            Text("지출: 1,000,000원")
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
}
