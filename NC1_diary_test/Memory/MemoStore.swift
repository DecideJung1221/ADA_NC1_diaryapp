//
//  MemoStore.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/10/24.
//

import Foundation

class MemoStore: ObservableObject{
    
    //새로운 값을 저장할 때마다 바인딩 되어 있는 ui가 자동으로 업데이트 된다.
    @Published var list: [Memo]

    init(){
        list = [
            Memo(content: "Hello", insertDate: Date.now, money: 30000),
            Memo(content: "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24), money: 30000),
            Memo(content: "wow", insertDate: Date.now.addingTimeInterval(3600 * -48), money: 30000),
            Memo(content: "Hello", insertDate: Date.now, money: 30000),
            Memo(content: "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24), money: 30000),
            Memo(content: "wow", insertDate: Date.now.addingTimeInterval(3600 * -48), money: 30000),
            Memo(content: "Hello", insertDate: Date.now, money: 30000),
            Memo(content: "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24), money: 30000),
            Memo(content: "wow", insertDate: Date.now.addingTimeInterval(3600 * -48), money: 30000)
            
        ]
    }
    
    func insert(memo: String, date: Date, money: Int){
        
        //새로운 메모는 0번 인덱스에 추가
        list.insert(Memo(content: memo,insertDate: date, money: money), at: 0)
    }
    
    func update(memo: Memo?,content: String,date: Date){
        guard let memo = memo else {
            return
        }
        memo.content = content
        memo.insertDate = date
    }
    
    
    //2가지 방법의 delete
    func delete(memo: Memo){
        list.removeAll{$0.id == memo.id}
    }
    
    func delete(set: IndexSet){
        for index in set{
            list.remove(at: index)
        }
    }
    
}
