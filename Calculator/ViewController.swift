//
//  ViewController.swift
//  Calculator
//
//  Created by Masashi Aso on 2022/05/06.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var label: UILabel!
  
  @IBOutlet var button0: UIButton!
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  @IBOutlet var button4: UIButton!
  @IBOutlet var button5: UIButton!
  @IBOutlet var button6: UIButton!
  @IBOutlet var button7: UIButton!
  @IBOutlet var button8: UIButton!
  @IBOutlet var button9: UIButton!
  
  @IBOutlet var buttonPlus: UIButton!
  @IBOutlet var buttonMinus: UIButton!
  @IBOutlet var buttonMulti: UIButton!
  @IBOutlet var buttonDivide: UIButton!
  
  @IBOutlet var buttonEqual: UIButton!
  
  var num1: Int = 0
  // 0:+, 1:-, 2:*, 3:/
  var ope: Int?
  var num2: Int?
  
  // これが教科書通り
  @IBAction func button0Tapped(_ sender: UIButton) {
    if num2 != nil {
      num2 = num2! * 10 + 0
    } else if ope != nil {
      num2 = 0
    } else {
      num1 = num1 * 10 + 0
    }
    updateLabel()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // おそらくこの段階では説明しないが、関連付けで手が疲れた人向け
    // って思ったけど、これは弱参照のせいで大変なことになっちゃった
    button1.addAction(UIAction { [weak self] action in
      if self?.num2 != nil {
        self?.num2 = (self?.num2)! * 10 + 1
      } else if self?.ope != nil {
        self?.num2 = 1
      } else if self?.num1 != nil {
        self?.num1 = (self?.num1)! * 10 + 1
      }
      self?.updateLabel()
    }, for: .touchUpInside)
    // 同じくやるか怪しいが、僕みたいに同じこと書くの嫌な子のために。
    // （実際初キャンプでIBActionを1個にまとめられない？と聞いていた）
    func numberTapped(num: Int) {
      if num2 != nil {
        num2 = num2! * 10 + num
      } else if ope != nil {
        num2 = num
      } else {
        num1 = num1 * 10 + num
      }
      updateLabel()
    }
    button2.addAction(UIAction { _ in numberTapped(num: 2) }, for: .touchUpInside)
    button3.addAction(UIAction { _ in numberTapped(num: 3) }, for: .touchUpInside)
    button4.addAction(UIAction { _ in numberTapped(num: 4) }, for: .touchUpInside)
    button5.addAction(UIAction { _ in numberTapped(num: 5) }, for: .touchUpInside)
    button6.addAction(UIAction { _ in numberTapped(num: 6) }, for: .touchUpInside)
    button7.addAction(UIAction { _ in numberTapped(num: 7) }, for: .touchUpInside)
    button8.addAction(UIAction { _ in numberTapped(num: 8) }, for: .touchUpInside)
    button9.addAction(UIAction { _ in numberTapped(num: 9) }, for: .touchUpInside)
  }
  
  func calc() {
    guard ope != nil && num2 != nil else { return }
    if ope == 0 {
      num1 = num1 + num2!
    } else if ope == 1 {
      num1 = num1 - num2!
    } else if ope == 2 {
      num1 = num1 * num2!
    } else if ope == 3 {
      if num2 != 0 {
        num1 = num1 / num2!
      }
    }
    ope = nil
    num2 = nil
  }
  
  @IBAction func tapEqual(_ sender: UIButton) {
    calc()
    updateLabel()
  }
  
  @IBAction func tapPlus(_ sender: UIButton) {
    calc()
    ope = 0
    updateLabel()
  }
  
  @IBAction func tapMinus(_ sender: UIButton) {
    calc()
    ope = 1
    updateLabel()
  }
  
  @IBAction func tapMulti(_ sender: UIButton) {
    calc()
    ope = 2
    updateLabel()
  }
  
  @IBAction func tapDivide(_ sender: UIButton) {
    calc()
    ope = 3
    updateLabel()
  }
  
  func updateLabel() {
    label.text = num1.description
    if num1 > 10 {
      label.textColor = .red
    } else if num1 < -10 {
      label.textColor = .blue
    } else {
      label.textColor = .white
    }
    
    if ope == 0 {
      label.text! += " +"
    } else if ope == 1 {
      label.text! += " -"
    } else if ope == 2 {
      label.text! += " ×"
    } else if ope == 3 {
      label.text! += " ÷"
    } else {
      return
    }
    
    if num2 != nil {
      label.text! += " \(num2!)"
    }
  }
  
  @IBAction func clear() {
    num1 = 0
    ope = nil
    num2 = nil
    updateLabel()
  }

}

