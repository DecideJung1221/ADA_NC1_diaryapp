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

            
            if memo.money <= 0 {
                
                Image(systemName: "pencil.tip.crop.circle.badge.plus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(.red )
            }else{
                Image(systemName: "pencil.tip.crop.circle.badge.minus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(.blue)
            }
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text(memo.title)
                        .font(.caption)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Text(memo.time, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .monospacedDigit()
            .padding(.horizontal,5)
            .frame(width: 150)
            HStack{
                if memo.money <= 0 {
                    Text("\(memo.money)")
                        .font(.body.bold())
                        .foregroundStyle(.red)
                        .padding(.horizontal,5)
                }else{
                    Text("\(memo.money)")
                        .foregroundStyle(.blue)
                        .padding(.horizontal,5)
                        .font(.body.bold())
                }
                Spacer()
            }
        }
        .padding()
    }
}


