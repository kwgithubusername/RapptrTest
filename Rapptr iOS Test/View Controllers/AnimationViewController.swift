//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var fadeButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        let isVisible = self.logoImageView.alpha == 1
        let newTitle = isVisible ? "FADE IN" : "FADE OUT"
        fadeButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            let newValue: CGFloat = isVisible ? 0 : 1
            self.logoImageView.alpha = newValue
        } completion: { _ in
            self.fadeButton.isUserInteractionEnabled = true
            self.fadeButton.setTitle(newTitle, for: .normal)
        }
    }
}
