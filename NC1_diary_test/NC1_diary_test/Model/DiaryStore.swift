////
////  DiaryStore.swift
////  NC1_diary_test
////
////  Created by 정혜정 on 4/12/24.
////
//import Foundation
//
//struct DiaryStore: Identifiable, Codable {
//    var id: UUID = UUID()
//    var date: String
//    var content: String
//    var money: Int
//    var mood: Diary
//    //새로운 값을 저장할 때마다 바인딩 되어 있는 ui가 자동으로 업데이트 된다.
////    @Published var content: String
////    @Published var insertDate: Date
////    @Published var money: Int
//}
//
//extension DiaryStore {
//    private var dateComponent: DateComponents {
//        let calendar = Calendar(identifier: .gregorian)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
//        
//        let date = formatter.date(from: self.date)
//        let dc = calendar.dateComponents([.year, .month], from: date!)
//        return dc
//    }
//    
//    var monthlyIdentifier: String {
//        return "\(dateComponent.year!)-\(dateComponent.month!)"
//    }
//}
//
//
//extension DiaryStore {
//    static let list: [DiaryStore] = [
//        DiaryStore(date: "2022-04-01 00:01:01", content: "My Diary", money: 1000, mood: .good),
//        DiaryStore(date: "2022-04-03 00:01:01", content: "My Diary", money: 2000, mood: .great),
//        DiaryStore(date: "2022-04-05 00:01:01", content: "My Diary", money: 3000, mood: .great),
//        DiaryStore(date: "2022-04-10 00:01:01", content: "My Diary", money: 4000, mood: .great),
//        DiaryStore(date: "2022-04-11 00:01:01", content: "My Diary", money: 5000, mood: .great),
//        ]
//}
