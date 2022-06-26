//
//  ViewController.swift
//  Day6-Exercise-Shooting-Fish-Game
//
//  Created by Le Ngoc Phu on 26/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgGun: UIImageView!
    
    var wScreen: Double?
    var hScreen: Double?
    var wGun: Double?
    var hGun: Double?
    var position: CGPoint?
    var xPositionCurrent: CGFloat?
    var yPositionCurrent: CGFloat?
    var xPositionNew: CGFloat?
    var yPositionNew: CGFloat?
    var speed: Double?
    var angle: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wScreen = view.frame.width
        hScreen = view.frame.height
        wGun = imgGun.frame.width
        hGun = imgGun.frame.height
        speed = 3.0
        angle = 0.0
        xPositionCurrent = wScreen!/2
        yPositionCurrent = 0
        xPositionNew = wScreen!/2
        yPositionNew = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        position = touch.location(in: self.view)
    }
    
    @IBAction func tapOnScreen(_ sender: Any) {
        xPositionNew = position?.x
        yPositionNew = position?.y
        let limitY = hScreen! - hGun!
        if yPositionNew! < limitY {
            calculateRotate()
            rotateImage(speed: 1, goc: angle!)
        } else {
            print("Cannot rotate")
        }
        
    }
    
    func rotateImage(speed: Double, goc: CGFloat){
        UIView.animate(withDuration: speed) {
            self.imgGun.transform = self.imgGun.transform.rotated(by: goc)
        } completion: { [self] (done) in
            xPositionCurrent = xPositionNew
            yPositionCurrent = yPositionNew
        }
    }
    
    func calculateRotate(){
        let xGun: CGFloat = wScreen!/2
        let yGun: CGFloat = hScreen!
        
        let xA: CGFloat = xPositionCurrent!
        let yA: CGFloat = yPositionCurrent!
        
        let xB: CGFloat = xPositionNew!
        let yB: CGFloat = yPositionNew!
        
        let squareA = (xA - xGun)*(xA - xGun) + (yA - yGun)*(yA - yGun)
        let a = sqrt(squareA)
        
        let squareB = (xB - xGun)*(xB - xGun) + (yB - yGun)*(yB - yGun)
        let b = sqrt(squareB)
        
        let squareC = (xA - xB)*(xA - xB) + (yA - yB)*(yA - yB)
        let c = sqrt(squareC)
        
        let tuso = a*a + b*b - c*c
        let mauso = 2*a*b
        let cosC = tuso / mauso
        let arcCos = acos(cosC)
        if (xB > xA) {
            angle = arcCos
        } else {
            angle = -arcCos
        }
    }
    
}

