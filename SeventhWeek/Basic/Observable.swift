//
//  Observable.swift
//  SeventhWeek
//
//  Created by BAE on 2/5/25.
//

class Observable<T> {
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
