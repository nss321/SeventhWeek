//
//  ConfigUI.swift
//  SeventhWeek
//
//  Created by BAE on 2/3/25.
//

import UIKit

protocol ConfigUI {
    func configHierarchy()
    func configLayout()
    func configView()
}

extension ConfigUI where Self: BaseViewController {
    func configBackgroundColor() {
        print(#function, "extension")
        view.backgroundColor = .systemBackground
    }
}
