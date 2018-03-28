//
//  GameScene.swift
//  test
//
//  Created by Andrew Wright on 19/03/2018.
//  Copyright © 2018 Andrew Wright. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  private var label : SKLabelNode?
  private var numberNode : SKShapeNode?
  private var numberLabels: [SKLabelNode] = []
  
  private let instructions = [
    "Hi! Welcome to Mathematics. Tap to continue.",
    """
1, 2, 3, 4, 5, 6, ...
    
are the natural numbers.
"""
  ]
  
  override func didMove(to view: SKView) {
    self.label = SKLabelNode(text: instructions[0])
    if let label = self.label {
      label.numberOfLines = 0
      label.preferredMaxLayoutWidth = self.size.width
      label.text = instructions[0]
      label.alpha = 0.0
      label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
      label.fontSize = 50.0
      self.addChild(label)
      label.run(SKAction.fadeIn(withDuration: 2.0))
    }
  }
  
  
  func touchDown(atPoint pos : CGPoint) {
  }
  
  func touchMoved(toPoint pos : CGPoint) {
  }
  
  func touchUp(atPoint pos : CGPoint) {
    guard let label = self.label else {
      return
    }
    
    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
    label.run(fadeOut, completion: {
      self.displayNumbers(upTo: 6)
    })
  }
  
  private func displayNumbers(upTo finalNumber: Int) {
    let circleDiameter: CGFloat = 80.0
    let circleRadius: CGFloat = circleDiameter / 2.0
    let spacing: CGFloat = 20.0
    let horizontalNodeCount: Int = Int(floor((self.size.width - spacing) / (circleDiameter + spacing)))
    let verticalNodeCount: Int = 10
    
    var counter: Int = 0
    
    for y in 0..<verticalNodeCount {
      for x in 0..<horizontalNodeCount {
        guard counter < finalNumber else {
          break
        }
        
        counter += 1
        let node = SKLabelNode(text: "\(counter)")
        var xPosition: CGFloat
        var yPosition: CGFloat
        if x == 0 {
          xPosition = spacing + circleRadius
        } else {
          xPosition = spacing + circleRadius + (CGFloat(x) * (circleDiameter + spacing))
        }
        
        if y == 0 {
          yPosition = self.size.height - (spacing + circleRadius)
        } else {
          yPosition = self.size.height - (spacing + circleRadius + (CGFloat(y) * (circleDiameter + spacing)))
        }
        
        node.position = CGPoint(x: xPosition, y: yPosition)
        node.alpha = 0.0
        node.name = "numberLabel_\(counter)"
        
        numberLabels.append(node)
        self.addChild(node)
      }
    }
    
    fadeInNumbersConsecutively(fromIndex: 0)
  }
  
  func fadeInNumbersConsecutively(fromIndex index: Int) {
    guard index < numberLabels.count else {
      return
    }
    
    let fadeIn = SKAction.fadeIn(withDuration: 1.0)
    numberLabels[index].run(fadeIn) {
      self.fadeInNumbersConsecutively(fromIndex: index + 1)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
}

