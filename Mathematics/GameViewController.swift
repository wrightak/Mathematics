//
//  GameViewController.swift
//  Mathematics
//
//  Created by Andrew Wright on 29/03/2018.
//  Copyright © 2018 Andrew Wright. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let view = self.view as! SKView? else {
      return
    }
    
    let transitionClosure = {
      let nextScene = StepOneScene(size: view.bounds.size)
      
      let transition = SKTransition.reveal(
        with: .down,
        duration: 1.0
      )
      
      nextScene.scaleMode = .aspectFill
      
      view.presentScene(nextScene, transition: transition)
    }
    
    let scene = StepZeroScene(size: view.bounds.size, transitionToNextScene: transitionClosure)
    scene.scaleMode = .aspectFill
    view.presentScene(scene)
    
    view.ignoresSiblingOrder = true
    
    view.showsFPS = true
    view.showsNodeCount = true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
