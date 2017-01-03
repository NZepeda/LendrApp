//
//  CircularImage.swift
//  LendrApp
//
//  Created by Nestor Zepeda on 1/2/17.
//  Copyright © 2017 Lendr. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 20;
        self.clipsToBounds = true;
    }
    

}
