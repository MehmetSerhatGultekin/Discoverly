//
//  Extensions.swift
//  Discoverly
//
//  Created by Özgün Şimşek on 3.07.2025.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
