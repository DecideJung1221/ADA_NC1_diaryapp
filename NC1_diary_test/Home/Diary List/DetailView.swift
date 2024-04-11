//
//  DetailView.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/11/24.
//


import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    
    @EnvironmentObject var store: MemoStore
    
    @State private var showCompose = false
    @State private var showDeleteAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
        VStack{
            ScrollView{
                VStack{
                    Text("\(memo.money)원 돈의 가치를 했늬,,?")
                    HStack{
                        Text(memo.content)
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate,style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                Button{
                    showCompose = true
                }label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showCompose, content: {
            ComposeView(memo: memo)
        })
            

            Button{
                showDeleteAlert = true
            }label: {
                Image(systemName: "trash")
            }
            .foregroundColor(.red)
            .alert("삭제확인", isPresented: $showDeleteAlert)
            {
                Button(role: .destructive){
                    store.delete(memo: memo)
                    dismiss()
                }label: {
                    Text("삭제")
                }
            }message: {
                Text("삭제할까요?")
            }
            
        
        }
        
    }
}

#Preview {
    NavigationView(content: {
        DetailView(memo: Memo(content: "Hello",insertDate: Date.now,money: 30))
            .environmentObject(MemoStore())
    })
    
}
