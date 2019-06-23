//
//  LeftHalfCalculation.swift
//  Rectangle, Ported from Spectacle
//
//  Created by Ryan Hanson on 6/13/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Foundation

class LeftHalfCalculation: WindowCalculation {
    
    func calculate(_ windowRect: CGRect, visibleFrameOfSourceScreen: CGRect, visibleFrameOfDestinationScreen: CGRect, action: WindowAction) -> CGRect? {
        
        var oneHalfRect = visibleFrameOfDestinationScreen
        oneHalfRect.size.width = floor(oneHalfRect.width / 2.0)
        
        if !Defaults.strictWindowActions.enabled {
            if abs(windowRect.midY - oneHalfRect.midY) <= 1.0 {
                var twoThirdRect = oneHalfRect
                twoThirdRect.size.width = floor(visibleFrameOfDestinationScreen.width * 2 / 3.0)
                if rectCenteredWithinRect(oneHalfRect, windowRect) {
                    return twoThirdRect
                }
                if rectCenteredWithinRect(twoThirdRect, windowRect) {
                    var oneThirdsRect = oneHalfRect
                    oneThirdsRect.size.width = floor(visibleFrameOfDestinationScreen.width / 3.0)
                    return oneThirdsRect
                }
            }
        }
        
        return oneHalfRect
    }
    
}
