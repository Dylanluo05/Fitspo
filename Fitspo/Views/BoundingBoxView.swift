//
//  BoundingBoxView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/19/26.
//

import SwiftUI

struct BoundingBoxView: View {
    
    let box: [Double]
    let imageSize: CGSize
    
    var body: some View {
        GeometryReader { geo in
            
            let displayedWidth = geo.size.width
            let displayedHeight = geo.size.height
            
            let scaleX = displayedWidth / imageSize.width
            let scaleY = displayedHeight / imageSize.height
            
            let x = box[0] * scaleX
            let y = box[1] * scaleY
            let width = (box[2] - box[0]) * scaleX
            let height = (box[3] - box[1]) * scaleY
            
            Rectangle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: width, height: height)
                .position(x: x + width / 2, y: y + height / 2)
        }
    }
    
}
