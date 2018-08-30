//
//  GradientView.swift
//  Project37
//
//  Created by Charles Martin Reed on 8/30/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    //has a top and bottom color for our gradient, but the values should be visible and editable within IB.
    @IBInspectable var topColor: UIColor = UIColor.white
    @IBInspectable var bottomColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        //iOS should use a CAGradientLayer for drawing
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        //iOS should apply the gradient colors when laying out the subviews
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    //IBDesignable = IB should build the class and make it draw inside of IB whenever changes are made.
    //IBInspectable exposes a property from class as an editable value in IB.


}
