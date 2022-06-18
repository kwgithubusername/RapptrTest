//
//  DraggableImageView.swift
//  Rapptr iOS Test
//
//  Created by Jack on 6/17/22.
//

import UIKit

class DraggableImageView: UIImageView {
      var beganPoint: CGPoint? = nil
      var originCenter: CGPoint? = nil
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let position = touches.first?.location(in: superview){
                beganPoint = position
                originCenter = center
           }
      }
      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      }
      override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let position = touches.first?.location(in: superview){
                let newPosition = CGPoint(x: position.x - (beganPoint?.x)!, y: position.y - (beganPoint?.y)!)
                center = CGPoint(x: (originCenter?.x)! + newPosition.x, y: (originCenter?.y)! + newPosition.y)
           }
      }
}
