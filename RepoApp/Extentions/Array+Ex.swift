//
//  Array+Ex.swift
//  RepoApp
//
//  Created by Igor Novoseltsev on 13.04.21.
//

import Foundation

extension Array {
    func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> Void) {
        self.enumerated().forEach(body)
    }

    func get(by index: Int) -> Element? {
        if index < 0 || index >= count {
            return nil
        } else {
            return self[index]
        }
    }
}
