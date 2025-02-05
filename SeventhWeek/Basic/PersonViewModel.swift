//
//  PersonViewModel.swift
//  SeventhWeek
//
//  Created by BAE on 2/5/25.
//

class PersonViewModel {
    // 테이블뷰에 보여줄 데이터
    var people: Observable<[Person]> = Observable([])
    let navigationTitle = "Person List"
    let resetTitle = "리셋 버튼"
    let loadTitle = "로드 버튼"
    
    var inputLoadButtonTapped: Observable<Void> = Observable(())
    
    init() {
        inputLoadButtonTapped.bind { [self] _ in
            people.value.append(contentsOf: generateRandomPeople())
        }
    }
    
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
}

