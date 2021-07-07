//
//  DataService.swift
//  FileManager-UseDefauls
//
//  Created by DCS on 07/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class DataService {
    func getDocDir() -> URL
    {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("path::  \(path[0])")
        return path[0]
    }
    
}
