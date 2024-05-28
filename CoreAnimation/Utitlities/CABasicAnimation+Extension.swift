//
//  CABasicAnimation+Extension.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 5/27/24.
//

import QuartzCore

extension CABasicAnimation {
    public convenience init(keyPath: AnimationKeyPath) {
        self.init(keyPath: keyPath.rawValue)
    }
    
    public enum AnimationKeyPath: String {
        case opacity = "opacity"
        case positionX = "position.x"
        case positionY = "position.y"
        case transformScale = "transform.scale"
        case backgroundColor = "backgroundColor"
        case boundsSizeWidth = "bounds.size.width"
    }
}
