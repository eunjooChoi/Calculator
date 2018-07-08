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
    
    private enum Operation  {
        /*
         operations 딕셔너리에 모든 연산 수식을 넣고 싶은데,
         루트나 +, -는 Double형이 아니기 때문에 딕셔너리에 넣을 수 없다.
         이럴 때 enum을 사용하여 종류를 확정지어주면 operations에서는
         해당 수식이 어떤 operator인지 알 수 있다
         또한 케이스마다 연관값을 줄 수 있어서 ()로 연관값을 설정할 수 있다
         연관값에는 일반적인 데이터 타입 뿐만 아니라 함수 타입도 설정 가능하다
         */
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation(( Double,Double) -> Double)
        case Equals
    }
    
    private var operations: Dictionary <String, Operation> = [
        "PIE": Operation.Constant(Double.pi), //Double.pi,
        "e": Operation.Constant(M_E), // M_E
        "√": Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        
        // 바이너리 연산 함수를 따로 만들 필요 없이 클로저를 활용해서 바로 쓸 수 있다.
        // 이 때 매개변수, 반환형은 enum에서 정의한 타입을 통해 추론할 수 있기 때문에 모두 생략해주었다.
        "+": Operation.BinaryOperation({$0 + $1}),
        "*": Operation.BinaryOperation({$0 * $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "/": Operation.BinaryOperation({$0 / $1}),
        "=": Operation.Equals
    ]
    
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
        if let operation = operations[symbol] {
            switch operation {
            // case안에 있는 임시변수는 딕셔너리의 값을 뺴오기 위함
            case .BinaryOperation(let associatedFunc):
                executeBinaryOperation()
                pending = PendingBinaryInfo(binaryFunction: associatedFunc, firstOperand: accumulator) // 생성자
            case .UnaryOperation(let associatedFunc):
                accumulator = associatedFunc(accumulator)
            case .Constant(let associatedValue):
                accumulator = associatedValue
            case .Equals:
                executeBinaryOperation()
            }
        }
    }
    
    /*
     이항연산을 할 때는 값이 두 개가 있어야하고, 연산수식을 눌렀을 때 앞에 연산자 하나가 할당 되어있어야한다
     이런 정보들을 저장하고 있는 구조체를 하나 생성한다.
     */
    private struct PendingBinaryInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private  var pending: PendingBinaryInfo? // 곱셈이나 나눗셈같은 것 말고 다른 것을 입력하면 이 변수가 닐이었으면 좋겠다
    
    /*
     함수 내용에 있는 것을 equal에만 실행하면 4*5*8같이 여러번 계산하는 식을 계산할 수 없다
     */
    private func executeBinaryOperation(){
        // pending이 있어야 = 연산을 수행할 수 있기 때문에 if를 걸어주었다
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil       // 연산을 실행한 후에 pending은 필요없기 떄문에 nil로 변경한다
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
