//
//  MoreProductsView.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 12/10/2023.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        VStack {
            Text("More Products ")
                .font(.title2.bold())
                .frame(maxWidth: .infinity , alignment: .leading)
                }
        .frame(maxWidth: .infinity , maxHeight: .infinity , alignment: .topLeading)
        .padding()
        .background(Color("HomeBg").ignoresSafeArea())
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
