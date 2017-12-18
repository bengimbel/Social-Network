//
//  CircleView.swift
//  Social-Network-Project
//
//  Created by Ben Gimbel on 12/15/17.
//  Copyright © 2017 Ben Gimbel. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
