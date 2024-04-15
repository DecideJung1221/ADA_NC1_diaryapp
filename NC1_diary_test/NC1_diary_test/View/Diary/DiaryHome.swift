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
                            Text("4월")
                                .font(.title2)
                            VStack{
                                
                                Button{print("upper")
                                }label: {
                                    Image(systemName: "arrowtriangle.up.fill")
                                        .resizable()
                                        .frame(width: 10,height: 10)
                                }
                                Button{print("down")
                                }label: {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .resizable()
                                        .frame(width: 10,height: 10)
                                }
                                
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
}
