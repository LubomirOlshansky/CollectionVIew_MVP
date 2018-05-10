//
//  ElementsModel.swift
//  Daftcode_praktyki
//
//  Created by Lubomir Olshansky on 10/05/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation

struct Element {
    var number: Int
    var color: Color
    
    init() {
        self.number = Int(arc4random_uniform(10))
        self.color = Color.randomColor()
    }
}

enum Color {
    case red
    case blue
    
    static func randomColor() -> Color {
        let colorsToGetRandomly = [Color.red, Color.blue]
        let index = Int(arc4random_uniform(UInt32(colorsToGetRandomly.count)))
        let color = colorsToGetRandomly[index]
        return color
    }
}


