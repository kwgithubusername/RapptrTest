//
//  RainbowView.swift
//  Rapptr iOS Test
//
//  Created by Jack on 6/17/22.
//

import UIKit

class RainbowView: UIView {

        var segmentCount: Int = 10 {
            didSet {
                refresh()
            }
        }
        var lineWidth: CGFloat = 10 {
            didSet {
                refresh()
            }
        }

        override var frame: CGRect {
            didSet {
                refresh()
            }
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            refresh()
        }

        private var currentGradientLayer: CAGradientLayer?

        private func refresh() {
            currentGradientLayer?.removeFromSuperlayer()

            guard segmentCount > 0 else { return }

            currentGradientLayer = {
                let gradientLayer = CAGradientLayer()
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
                gradientLayer.type = .conic
                let colors: [UIColor] = {
                    var colors: [UIColor] = [UIColor]()
                    for i in 0..<segmentCount {
                        colors.append(UIColor(hue: CGFloat(i)/CGFloat(segmentCount), saturation: 1, brightness: 1, alpha: 1))
                    }
                    colors.append(UIColor(hue: 0.0, saturation: 1, brightness: 1, alpha: 1)) // Append start color at the end as well to complete the circle
                    return colors;
                }()
                gradientLayer.colors = colors.map { $0.cgColor }

                gradientLayer.frame = bounds
                layer.addSublayer(gradientLayer)

                gradientLayer.mask = {
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.frame = bounds
                    shapeLayer.lineWidth = lineWidth
                    shapeLayer.strokeColor = UIColor.white.cgColor
                    shapeLayer.fillColor = UIColor.clear.cgColor
                    shapeLayer.path = UIBezierPath(ovalIn: bounds.inset(by: UIEdgeInsets(top: lineWidth*0.5, left: lineWidth*0.5, bottom: lineWidth*0.5, right: lineWidth*0.5))).cgPath
                    return shapeLayer
                }()

                return gradientLayer
            }()


        }

    }
