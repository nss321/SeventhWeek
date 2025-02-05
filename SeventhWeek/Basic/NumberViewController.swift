//
//  NumberViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit

/*
 1. init
 2. didSet
 3. closure
 
 */

class Field<T> {
    private var closure: ((T) -> Void)?
    var value: T {
        didSet {
            closure?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    
    // bind에 작성한 구문이 바로 동작하게끔 하고 싶은 경우
    func bind(closure: @escaping (T) -> Void) {
        closure(value) // didSet 된 것 같은 효과를 줄 수 있음
        self.closure = closure
    }
    
    func lazyBind(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}

class NumberViewController: UIViewController {
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.borderStyle = .bezel
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
       
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        configureActions()
        viewModel.outputText.bind {
            self.formattedAmountLabel.text = $0
        }
        viewModel.outputTextColor.bind {
            self.formattedAmountLabel.textColor = $0 ? .blue : .red
        }
    }
 
    @objc private func amountChanged() {
        print(#function)
        /*
         공백 - 값을 입력해주세요.
         문자 - 숫자를 입력해주세요.
         숫자 범위 - 100만원 이하의 값을 작성해주세요.
         */
        
        viewModel.inputField.value = amountTextField.text
    }
}

extension NumberViewController {
    
    private func configureUI() {
        print(#function)
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
    }

    private func configureConstraints() {
        print(#function)
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }

    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }

}
