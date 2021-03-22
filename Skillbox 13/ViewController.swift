//
//  ViewController.swift
//  Skillbox 13
//
//  Created by Артём on 5/18/20.
//  Copyright © 2020 Artem A. All rights reserved.
//

/*Для всех задач сделайте один проект с одним экраном, где будет кнопки «предыдущая» и «следующая» внизу экрана, а между ними – номер текущей анимации. Этими кнопками можно выбрать нужную анимацию. Номер анимации – это номер задачи из списка ниже. Все анимации применяются к красному квадрату наверху экрана. Все анимации суммарно длятся две секунды (кроме последней) и после завершения возвращают квадрат в тоже состояние, что он был до анимации. Итак, сделайте следующие анимации:

Изменение цвета фона квадрата на желтый
Перемещение в правый верхний угол экрана
Закругление краев, чтобы он выглядел как круг
Поворот на 180 градусов
«Исчезание»
Сначала увеличение в два раза, потом анимированное уменьшение обратно
Бесконечную анимацию поворота */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redSquare: UIView!
    @IBOutlet weak var currentAnimation: UIButton!
    @IBOutlet weak var xConstraint: NSLayoutConstraint!
    var animations = ["1", "2", "3", "4", "5", "6", "7"]
    var i = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentAnimation.setTitle("\(animations[i])", for: .normal)
        repeatButton((Any).self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        if i < animations.count && i > 0{
            i -= 1
            currentAnimation.setTitle("\(animations[i])", for: .normal)
            repeatButton((Any).self)
        } else {return}
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if i < animations.count && i < animations.count - 1{
            i += 1
            currentAnimation.setTitle("\(animations[i])", for: .normal)
            repeatButton((Any).self)
        } else {return}
    }
    
    @IBAction func repeatButton(_ sender: Any) {
        
        currentAnimation.setTitle("\(animations[i])", for: .normal)
        
        switch animations[i] {
        case "1":
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.redSquare.backgroundColor = UIColor.yellow
            }) { (isComplited) in
                self.redSquare.backgroundColor = UIColor.red
            }
            print("1 complited")
        case "2":
            self.xConstraint.constant = 0
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn, .autoreverse ], animations: {
                self.xConstraint.constant = (self.view.frame.width - self.redSquare.frame.width) / 2
                self.view.layoutIfNeeded()
            }) { (isComplited) in
                self.xConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            print("2 complited")
            
        case "3":
            let cornerRadiusAnim = CABasicAnimation(keyPath: "cornerRadius")
            cornerRadiusAnim.fromValue = NSNumber(value: 0)
            cornerRadiusAnim.toValue = NSNumber(value: Float(redSquare.frame.width / 2))
            cornerRadiusAnim.duration = 2.0
            redSquare.layer.add(cornerRadiusAnim, forKey: "cornerRadius")
//            redSquare.layer.cornerRadius = redSquare.frame.width / 2
           
            print("3 complited")
            
        case "4":
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.redSquare.transform = CGAffineTransform(rotationAngle: .pi)
            }) { (isComplited) in
                self.redSquare.transform = CGAffineTransform(rotationAngle: 0)
                       }
            print("4 complited")
            
        case "5":
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.redSquare.alpha = 0
            }) { (isComplited) in
                self.redSquare.alpha = 1
                       }
            print("5 complited")
            
        case "6":
            let doubleAnim = CABasicAnimation(keyPath: "transform.scale")
            doubleAnim.fromValue = 1
            doubleAnim.toValue = 2
            doubleAnim.duration = 2.0
            doubleAnim.autoreverses = true
            doubleAnim.repeatCount = 1
            redSquare.layer.add(doubleAnim, forKey: "transform.scale")
            
            print("6 complited")
            
        case "7":
            let rotationAnim = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnim.fromValue = 0.0
            rotationAnim.toValue = Double.pi * 2
            rotationAnim.duration = 1
            rotationAnim.repeatCount = 5 /* .infinity */
            redSquare.layer.add(rotationAnim, forKey: "transform.rotation")
            
            print("7 complited")
            
        default:
            break
        }
        
        
    }
    
    

}

