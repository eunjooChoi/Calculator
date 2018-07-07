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
    
    var operations: Dictionary <String, Double> = [ "PIE": Double.pi, "e": M_E]
    
    func performOperation(symbol: String){
        
        // 이렇게 구현하면 switch문에 너무 많은 조건이 들어가게 되고 그러면 많이 지저분해진다
        // 그래서 위에 딕셔너리 형으로 상수연산자들을 지정해두고 상수 연산자 버튼이 눌렸을 때 위에 저장한 함수를 실행하도록 만들었다
        //        switch symbol {
        //        case "PIE":
        //            accumulator = Double.pi
        //        case "√":
        //            accumulator = sqrt(accumulator)
        //        default:
        //            break
        //        }
        
        
        // 그런데 딕셔너리에 symbol을 키로 갖는 값이 없을 수도 있으므로 반환형이 옵셔널이다
        if let constant = operations[symbol] {
            accumulator = constant
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
