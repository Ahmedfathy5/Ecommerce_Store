//
//  StaggeredGrid.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 14/10/2023.
//

import SwiftUI

struct StaggeredGrid<Content : View , T:Identifiable>: View where T : Hashable {
    
    
    var content : (T) -> Content
    var list : [T]
    var coulmns : Int
    var showsIndicators: Bool
    var spacing:CGFloat
     
    init(coulmns:Int , showsIndicators: Bool = false ,spacing:CGFloat = 10 , list : [T] , @ViewBuilder content: @escaping (T)->Content ) {
        self.content = content
        self.list = list
        self.coulmns = coulmns
        self.showsIndicators = showsIndicators
        self.spacing = spacing
    }
    func setUpList()-> [[T]] {
        var gridArray:[[T]] = Array(repeating: [], count: coulmns)
        var currentIndex = 0
        
        for object in list {
            gridArray[currentIndex].append(object)
            
            
            if currentIndex == (coulmns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        return gridArray
    }
    var body: some View {
        HStack(alignment: .top, spacing: 20 ) {
            ForEach(setUpList(),id: \.self) { coulmnsData in
                LazyVStack(spacing:spacing) {
                    ForEach(coulmnsData) { object in
                        content(object)
                    }
                }
                .padding(.top , getIndex(values: coulmnsData) == 1 ? 80 : 0)
            }
        }
        .padding(.vertical)
        
    }
    func getIndex(values : [T])-> Int {
        let index = setUpList().firstIndex { t in
            return t == values
        } ?? 0
        return index
    }
}



struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
