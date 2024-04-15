//
//  homeTabView.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/10/24.
//
import SwiftUI

struct homeTabView: View{
    //tabview
    @State private var selection = 0
    
    @Binding var showHomeView: Bool
    
    //메모 저장소를 속성으로 먼저 저장
    @StateObject var store = MemoStore()
    @State var currentDate: Date = Date()
    
    var body: some View{
        TabView(selection: $selection){
            
//            Text("리스트")
            DiaryHome()
                .environmentObject(store)
                .tabItem {
                    Label("리스트", systemImage: "list.clipboard")
                        .foregroundColor(.black)
                }
                .tag(0)
            
            CustomDatePicker(currentDate: $currentDate)
                .environmentObject(store)
                .environmentObject(store)
                .tabItem {
                    Label("캘린더", systemImage: "calendar")
                        .foregroundColor(.black)
                }
                .tag(1)
            
            Text("커뮤니티")
                .tabItem {
                    Label("커뮤니티", systemImage: "figure.stand")
                }
                .tag(2)
        }
    }
    
}



