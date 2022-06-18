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
    var logoImageView = MovableImageView()
    @IBOutlet weak var fadeButton: UIButton!
    @IBOutlet weak var rainbowButton: UIButton!
    private var timer: Timer?

    private var startingConstantPosX: CGFloat  = 0.0
    private var startingConstantPosY: CGFloat  = 0.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        setupLogoImageView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @IBAction private func didPressRainbow(_ sender: Any) {
        showRainbowView()
        rainbowButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.rainbowButton.alpha = 0
        }
    }

    @IBAction private func didPressFade(_ sender: Any) {        
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
    
    private func setupLogoImageView() {
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "ic_logo")
        
        view.addSubview(logoImageView)
        logoImageView.alpha = 0
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        logoImageView.horizontalConstraint = horizontalConstraint
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = logoImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        logoImageView.verticalConstraint = verticalConstraint
        view.addConstraint(verticalConstraint)
        
        view.addConstraint(logoImageView.heightAnchor.constraint(equalToConstant: 50))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func showRainbowView() {
        let size = view.frame.size
        let rainbow = RainbowView(frame: CGRect(x: size.width/2 - 50, y: size.height/2 - 50, width: 100.0, height: 100.0))
        
        var angle: CGFloat = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true, block: { _ in
            angle += 0.01
            rainbow.transform = CGAffineTransform(rotationAngle: angle)
        })

        view.addSubview(rainbow)
    }
}

extension AnimationViewController: UIGestureRecognizerDelegate {
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {

            print("view being moved is: \(logoImageView.tag)")

            startingConstantPosX = logoImageView.horizontalConstraint?.constant ?? 0
            startingConstantPosY = logoImageView.verticalConstraint?.constant ?? 0

        } else if gestureRecognizer.state == .changed {

            let translation = gestureRecognizer.translation(in: self.view)

            let newXConstant = startingConstantPosX + translation.x
            let newYConstant = startingConstantPosY + translation.y

            logoImageView.horizontalConstraint?.constant = newXConstant
            logoImageView.verticalConstraint?.constant = newYConstant
        }
    }
}

class MovableImageView: UIImageView {
    var horizontalConstraint: NSLayoutConstraint?
    var verticalConstraint: NSLayoutConstraint?
}
