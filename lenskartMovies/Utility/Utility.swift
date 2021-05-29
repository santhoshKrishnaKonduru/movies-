//
//  Utility.swift
//  lenskartMovies
//
//  Created by Santhosh Konduru on 29/05/21.
//

import Foundation
import UIKit



func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}


