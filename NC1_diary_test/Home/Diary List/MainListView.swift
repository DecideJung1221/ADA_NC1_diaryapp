//
//  MainListView.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/11/24.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore
    
    //compose뷰를 사용할 때 이용
    @State private var showComposer: Bool = false
    
    let columns = [GridItem(.flexible())]
    let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
    
    var body: some View {
        
        NavigationView{
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 10) {
                                    ForEach(colors, id: \.self) { color in
                                        HStack{
                                            Rectangle()
                                                .foregroundColor(color)
                                                .frame(width: 400, height: 100)
                                        }
                                    }
                                
                            }
                            .frame(width: 350, height: 100)
                            .padding()
                        }
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                          ForEach(store.list) { memo in
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
}




