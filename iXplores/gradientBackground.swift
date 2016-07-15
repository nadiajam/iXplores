//
//  gradientBackground.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/15/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    func gradientBackground() -> CAGradientLayer {
        let topColor = UIColor(red: 99.0/255.0, green: 158.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 222.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}
