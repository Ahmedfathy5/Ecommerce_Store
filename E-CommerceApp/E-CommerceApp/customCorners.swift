//
//  customCorners.swift
//  E-CommerceApp
//
//  Created by Ahmed Fathi on 09/10/2023.
//

import SwiftUI

struct customCorners: Shape {
    var corner : UIRectCorner
    var raduis: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: raduis, height: raduis))
        return Path(path.cgPath)
    }
}

