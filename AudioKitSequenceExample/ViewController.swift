//
//  ViewController.swift
//  AudioKitSequenceExample
//
//  Created by Daisaku Ejiri on 2022/12/03.
//

import UIKit

class ViewController: UIViewController {
  
  let playSound = PlaySound.shared

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    playSound.play()
  }


}

