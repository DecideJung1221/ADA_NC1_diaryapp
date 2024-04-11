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
            Memo(content: "월급이 들어왔다!! 너무 기쁘다 행복하다", insertDate: Date.now, money: 1000000),
            Memo(content: "학식먹음 핫도그 짱 맛나", insertDate: Date.now.addingTimeInterval(3600 * -24), money: -3000),
            Memo(content: "무엇을 샀을까 껄껄", insertDate: Date.now.addingTimeInterval(3600 * -48), money: -203000),
            Memo(content: "까까 내기 승리!!!", insertDate: Date.now, money: 1000),
            Memo(content: "연못에서 동전을 주움 껄껄껄껄", insertDate: Date.now.addingTimeInterval(3600 * -24), money: 100)
            
        ]
    }
    
    func insert(memo: String, date: Date, money: Int){
        
        //새로운 메모는 0번 인덱스에 추가
        list.insert(Memo(content: memo,insertDate: date, money: money), at: 0)
    }
    
    func update(memo: Memo?,content: String,date: Date,money: Int){
        guard let memo = memo else {
            return
        }
        memo.content = content
        memo.insertDate = date
        memo.money = money
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
