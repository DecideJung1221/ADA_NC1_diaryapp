//
//  Task.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/15/24.
//

import Foundation
import SwiftUI

//Task Model and Sample Task...
//Array of Task
//struct Task: Identifiable{
//    var id = UUID().uuidString
//    var title: String
//    var time: Date = Date()
//}
class Task: Identifiable, ObservableObject{
    let id: UUID
    
    //새로운 값을 저장할 때마다 바인딩 되어 있는 ui가 자동으로 업데이트 된다.
    @Published var title: String
    @Published var time: Date = Date()
    @Published var money: Int
    init(title: String, time: Date, money: Int ) {
        id = UUID()
        self.title = title
        self.time = time
        self.money = money
    }
}

class MemoStore: ObservableObject{
    //새로운 값을 저장할 때마다 바인딩 되어 있는 ui가 자동으로 업데이트 된다.
    @Published var tasks: [Task]
    
    init(){
        tasks = [
            Task(title: "월급이 들어왔다!! 너무 기쁘다 행복하다", time: Date.now, money: 1000000),
            Task(title: "학식먹음 핫도그 짱 맛나", time: Date.now.addingTimeInterval(3600 * -24), money: -3000),
            Task(title: "무엇을 샀을까 껄껄", time: Date.now.addingTimeInterval(3600 * -48), money: -203000),
            Task(title: "까까 내기 졌다!!!", time: Date.now, money: -1000),
            Task(title: "연못에서 동전을 주움 껄껄껄껄", time: Date.now.addingTimeInterval(3600 * -24), money: 100)
            
        ]
    }
    
    func insert(memo: String, date: Date, money: Int){
        
        //새로운 메모는 0번 인덱스에 추가
        tasks.insert(Task(title: memo,time: date, money: money), at: 0)
    }
    
    func update(memo: Task?,content: String,date: Date,money: Int){
        guard let memo = memo else {
            return
        }
        memo.title = content
        memo.time = date
        memo.money = money
    }
    
    
    //2가지 방법의 delete
    func delete(memo: Task){
        tasks.removeAll{$0.id == memo.id}
    }
    
    func delete(set: IndexSet){
        for index in set{
            tasks.remove(at: index)
        }
    }
    
    

}

////Total Task Meta View...
//struct TaskMetaData: Identifiable{
//    var id = UUID().uuidString
//    var task: [Task]
//    var taskDate: Date
//}



//sample Date for testing
func getSampleDate(offset: Int) -> Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset , to: Date())
    
    return date ?? Date()
}

