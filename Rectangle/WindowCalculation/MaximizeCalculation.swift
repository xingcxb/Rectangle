//
//  MaximizeCalculation.swift
//  Rectangle, Ported from Spectacle
//
//  Created by Ryan Hanson on 6/14/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Foundation

class MaximizeCalculation: WindowCalculation {

    func calculate(_ windowRect: CGRect, visibleFrameOfSourceScreen: CGRect, visibleFrameOfDestinationScreen: CGRect, action: WindowAction) -> CGRect? {
        return visibleFrameOfDestinationScreen
    }
    
}
