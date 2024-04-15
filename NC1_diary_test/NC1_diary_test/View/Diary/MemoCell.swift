//
//  MemoCell.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/11/24.
//
import SwiftUI

//메모 셀
struct MemoCell: View{
    @ObservedObject var memo: Task
    
    var body: some View{
        HStack{
//            if let memo = memo{
                
                
//            }
            
            
            VStack(alignment: .leading){
                
                
                Text(memo.title)
                    .font(.caption)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(memo.time, style: .date)
                    .font(.caption)
                    .foregroundColor(.black)
                    
                
                
            }
            .monospacedDigit()
            .padding(.horizontal,5)
            .frame(width: 200)
            
            if memo.money <= 0 {
                Text("\(memo.money)")
                    .font(.body)
                    .foregroundStyle(.red)
                    .padding(.horizontal,5)
            }else{
                Text("\(memo.money)")
                    .foregroundStyle(.blue)
                    .padding(.horizontal,5)
                    .font(.body)
            }
        }
    }
}


