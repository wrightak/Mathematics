//
//  GameScene.swift
//  test
//
//  Created by Andrew Wright on 19/03/2018.
//  Copyright © 2018 Andrew Wright. All rights reserved.
//

import SpriteKit
import GameplayKit

class StepZeroScene: SKScene {

  private var label : SKLabelNode?
  private var numberLabels: [SKLabelNode] = []
  private var displayStarted: Bool = false
  private var displayFinished: Bool = false
  
  let transitionToNextScene: () -> Void
  
  init(size: CGSize, transitionToNextScene: @escaping () -> Void) {
    self.transitionToNextScene = transitionToNextScene
    super.init(size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMove(to view: SKView) {
    self.label = SKLabelNode(text: "Hi! Welcome to Mathematics. Tap to continue.")
    if let label = self.label {
      label.numberOfLines = 0
      label.preferredMaxLayoutWidth = self.size.width
      label.alpha = 0.0
      label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
      label.fontSize = 36.0
      self.addChild(label)
      label.run(SKAction.fadeIn(withDuration: 2.0))
    }
  }
  
  func touchUp(atPoint pos : CGPoint) {
    if displayFinished {
      transitionToNextScene()
      return
    }
    
    if !displayStarted {
      displayNumbersAndText()
      displayStarted = true
    }
  }
  
  private func displayNumbersAndText() {
    guard let label = self.label else {
      return
    }

    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
    label.run(fadeOut, completion: {
      self.displayNumbers(
        upTo: 7,
        atPosition: CGPoint(x: 0.0, y: self.size.height / 2),
        completion: {
          label.text = "These are the natural numbers"
          label.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 200)
          label.run(SKAction.fadeIn(withDuration: 0.2), completion: { self.displayFinished = true })
      })
    })
  }
  
  private func displayNumbers(
    upTo finalNumber: Int,
    atPosition position: CGPoint,
    completion: @escaping () -> Void
    ) {
    let circleDiameter: CGFloat = 40.0
    let circleRadius: CGFloat = circleDiameter / 2.0
    let spacing: CGFloat = 10.0
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
          xPosition = position.x + spacing + circleRadius
        } else {
          xPosition = position.x
            + spacing
            + circleRadius
            + (CGFloat(x) * (circleDiameter + spacing))
        }
        
        if y == 0 {
          yPosition = position.y
        } else {
          yPosition = position.y - (spacing + circleRadius + (CGFloat(y) * (circleDiameter + spacing)))
        }
        
        node.position = CGPoint(x: xPosition, y: yPosition)
        node.alpha = 0.0
        node.name = "numberLabel_\(counter)"
        
        numberLabels.append(node)
        self.addChild(node)
      }
    }
    
    fadeInNumbersConsecutively(fromIndex: 0, completion: completion)
  }
  
  private func fadeInNumbersConsecutively(fromIndex index: Int, completion: @escaping () -> Void) {
    guard index < numberLabels.count else {
      completion()
      return
    }
    
    let fadeIn = SKAction.fadeIn(withDuration: 0.4)
    numberLabels[index].run(fadeIn) {
      self.fadeInNumbersConsecutively(fromIndex: index + 1, completion: completion)
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
}

