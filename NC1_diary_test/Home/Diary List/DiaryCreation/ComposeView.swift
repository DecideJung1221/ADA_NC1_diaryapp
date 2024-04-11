//
//  ComposeView.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/10/24.
//
//
import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var date = Date()
    
    
    @State private var money = Int()
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    var memo: Memo? = nil
    
    //메모 창 닫기 dismiss방법을 이용
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack{
                DatePicker(
                     "날짜를 선택하세요",
                     
                     selection: $date,
                     displayedComponents: [.date]
                   )
                .onAppear{
                    if let memo = memo{
                        date = memo.insertDate
                    }
                }
                .padding()
                
                HStack(spacing: 20) {
                        Text("금액")
                        Spacer()
                        TextField("money", value: $money, formatter: formatter)
                        .onAppear{
                            if let memo = memo{
                                money = memo.money
                            }
                        }
                        .frame(alignment: .trailing)
                    }
                .padding()
                
                Text("상황")
                TextEditor(text: $content)
                    .padding()
                    .onAppear{
                        if let memo = memo{
                            content = memo.content
                        }
                    }
            }
            .navigationTitle(memo != nil ? "편집" : "new")
            .navigationBarTitleDisplayMode(.inline)
            //large title 모드는 사용하지 않음
            
            
            // 취소 dismiss 이용
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    }label: {
                        Text("취소")
                    }
                }
            }
            
            
            // Memostore의 insert를 사용하여 저장
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button{
                        if let memo = memo {
                            store.update(memo: memo, content: content, date: date, money: money)
                        }else{
                            
    //                        위의 texteditor의 text를 content로 받음
                            store.insert(memo: content,date: date,money: money)
                        }
                        
                        dismiss()
                    }label: {
                        Text("저장")
                    }
                }
            }
            
        }
    }
}
