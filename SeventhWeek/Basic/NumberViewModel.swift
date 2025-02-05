//
//  NumberViewModel.swift
//  SeventhWeek
//
//  Created by BAE on 2/5/25.
//

import Foundation

class NumberViewModel {
    // 뷰컨에서 사용자가 받아온 값 그 자체
    var inputField: Field<String?> = Field(nil)
    
    // 뷰컨 레이블에 보여줄 최종 텍스트
    var outputText = Field("")
    
    // 뷰컨에 레이블 텍스트 컬러로 사용할 것 -> 파랑(t), 빨강(f)
    var outputTextColor = Field(false)
    
    init() {
        print(#function, "init")
        self.inputField.bind {
            print(#function, $0)
            self.validation($0)
        }
    }
    
    private func validation(_ text: String?) {
        // 1. 옵셔널 바인딩
        guard let text else {
            outputText.value = ""
            outputTextColor.value = false
            return
        }
        
        // 2. 공백 체크
        if text.isEmpty {
            outputText.value = "값을 입력해주세요."
            outputTextColor.value = false
            return // early exit
        }
    
        // 3. 숫자 여부
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요."
            outputTextColor.value = false
            return
        }
        
        // 4. 범위 확인
        if num > 0, num <= 1000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            outputText.value = "₩" + result
            outputTextColor.value = true
        } else {
            outputText.value = "백먼원 이하를 입력해주세요."
            outputTextColor.value = false
        }
    }
}
