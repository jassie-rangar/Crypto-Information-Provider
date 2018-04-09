//
//  GradientCellView.swift
//  Crypto Info
//
//  Created by Jaskirat Singh on 02/04/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import UIKit

class GradientCellView: UITableView
{
    @IBInspectable var FirstColor: UIColor = UIColor.clear
        {
        didSet
        {
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear
        {
        didSet
        {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass
        {
        get
        {
            return CAGradientLayer.self
        }
    }
    
    func updateView()
    {
        let newLayer = self.layer as! CAGradientLayer
        newLayer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
}
