//
//  LoginViewModel.swift
//  SeventhWeek
//
//  Created by BAE on 2/5/25.
//

import Foundation

class LoginViewModel {
    
    // 실시간으로 달라지는 텍스트필드의 값을 전달받아옴
    let inputID: Field<String?> = Field(nil)
    let inputPW: Field<String?> = Field(nil)
    // 레이블만 텍스트로 내보내기
    let outputValidText = Field("")
    let outputValidTextColor = Field(false)
    // button enabled state
    let outputValidButton = Field(false)
    
    init() {
        inputID.bind { _ in
            print("id bind")
            self.validation()
        }
        inputPW.bind { _ in
            print("pw bind")
            self.validation()
        }
        
    }
    
    func validation() {
        guard let id = inputID.value,
              let pw = inputPW.value  else {
            outputValidText.value = "공백은 안대용"
            outputValidTextColor.value = false
            outputValidButton.value = false
            return
        }
        
        // 로그인 구현 시 아이디, 비번 중 잘못된 부분을 사용자에게 알려주면 안된다.
        // 해킹 위험이 있음.
        if id.count >= 4 && pw.count >= 4 {
            outputValidText.value = "참 자랫서용"
            outputValidTextColor.value = true
            outputValidButton.value = true
        } else {
            outputValidText.value = "ID는 4글자 이상이다 애송이"
            outputValidTextColor.value = false
            outputValidButton.value = false
        }
    }
}
