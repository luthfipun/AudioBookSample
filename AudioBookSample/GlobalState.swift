//
//  GlobalState.swift
//  AudioBookSample
//
//  Created by Luthfi Abdul Azis on 01/03/21.
//

import Foundation

class GlobalState: ObservableObject {
    @Published var isClicked: Bool = false
    @Published var item: Item?
    @Published var isHistory: Bool = false
}
