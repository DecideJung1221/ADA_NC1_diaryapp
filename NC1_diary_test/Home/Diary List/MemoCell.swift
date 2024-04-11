//
//  MemoCell.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/11/24.
//
import SwiftUI

//메모 셀
struct MemoCell: View{
    @ObservedObject var memo: Memo
    
    var body: some View{
        HStack{
            Text("\(memo.money)")
                .font(.body)
            
            VStack(alignment: .leading){
                
                
                Text(memo.content)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(memo.insertDate, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
            }
            .frame(width: 200)
        }
    }
}


#Preview {
    MemoCell(memo: Memo(content: "test",insertDate: Date.now,money: 2000))
}
