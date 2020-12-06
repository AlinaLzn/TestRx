//
//  ViewModel.swift
//  Test3_Bond
//
//  Created by Alina on 2020-11-26.
//

import Foundation
import Bond
import ReactiveKit

class ViewModel {
    
//    var name = Observable<String?>("")
//    var secondName = Observable<String?>("")
    var age = Observable<String?>("")

    var validName = Observable<Bool>(false)
    var validSecondName = Observable<Bool>(false)
    var validAge = Observable<Bool>(false)
    
    var valided = Observable<Bool>(true)

    func searchString() {
        combineLatest(self.validName.toSignal(), self.validSecondName.toSignal(), self.validAge.toSignal()) { name, secondName, age in
            return name && secondName && age
        }.bind(to: self.valided)

        //        if let name = name.value, let secondName = secondName.value, name != "", secondName != "" {
        //            if name.count < 3 {
        //                return false
        //            } else {
        //                return secondName.count > 3
        //            }
        //        } else {
        //            return false
    }
}
