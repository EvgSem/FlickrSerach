//
//  Result.swift
//  Flickr
//
//  Created by Ievgeniia Bondini on 5/19/21.
//

import Foundation


enum Result<T> {
    case success(T)
    case error(String)
}
