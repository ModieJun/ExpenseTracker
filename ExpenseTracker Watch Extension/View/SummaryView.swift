//
//  SummaryView.swift
//  ExpenseTracker Watch Extension
//
//  Created by Junjie Lin on 28/6/2021.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        VStack{
            Text("Dialy Expenses").font(.title3)
            List{
                ForEach(1...10,id:\.self){ ele in
                    Text("\(ele) value")
                }.onDelete(perform: { indexSet in
                    print("Index set ")
                })
            }
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
