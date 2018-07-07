 //
 //  CalculatorBrain.swift
 //  Calculator
 //
 //  Created by USER on 2018. 7. 6..
 //  Copyright © 2018년 Eunjoo. All rights reserved.
 //
 
 
 // 이곳은 mvc 중 model 부분입니다.
 // 모델은 앱의 기능을 구현해주는 곳으로 여기에 기능을 구현해두면
 // 컨트롤러는 연산 결과를 뷰에 전달해줍니다.
 import Foundation
 
 class CalcuatorBrain{
    
    
    private var accumulator = 0.0
    
    func setoperand(operand: Double){
        accumulator = operand
    }
    func performOperation(symbol: String){
        switch symbol {
        case "PIE":
            accumulator = Double.pi
        case "√":
            accumulator = sqrt(accumulator)
        default:
            break
        }
    }
    
    // 누군가 이 변수를 set하는건 말이 안됨.
    // 뷰에서 받은 값이 = 일 때 결과를 이 클래스에서 연산할 것이기 때문에
    // 읽기 전용 프로퍼티로 사용하자
    var result: Double {
        get{
            return accumulator
        }
    }
 }
