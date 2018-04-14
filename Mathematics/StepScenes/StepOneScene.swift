//
//  StepOneScene.swift
//  Mathematics
//
//  Created by Andrew Wright on 14/04/2018.
//  Copyright © 2018 Andrew Wright. All rights reserved.
//

import SpriteKit

class StepOneScene: SKScene {
  override func didMove(to view: SKView) {
    let label = SKLabelNode(text: "Step One")
    
    label.numberOfLines = 0
    label.preferredMaxLayoutWidth = self.size.width
    label.alpha = 0.0
    label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    label.fontSize = 50.0
    self.addChild(label)
    label.run(SKAction.fadeIn(withDuration: 2.0))
  }
}
