//
//  ContentView.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/10/24.
//

import SwiftUI
import CoreData

//struct ContentView: View {
//
//    var body: some View {
//            Text("Select an item")
//        }
//}




import SwiftUI

struct ContentView: View {
    @State var showHomeView = false
    
    var body: some View {
        ZStack{
            //            Color(Color.customBackgroundsky).ignoresSafeArea()
            if showHomeView {
                Text("showHomeView")
                homeTabView(showHomeView: self.$showHomeView)
//                    .environment(store)
            } else {
                VStack{
                    Image(systemName: "waveform")
                        .resizable()
                        .frame(width: 300,height: 300)
                    Button(action: {
                        self.showHomeView = true
                    }) {
                        Text("start")
                            .font(.title)
                            .foregroundStyle(Color(.black))
                    }
                    .offset(y:80)
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
