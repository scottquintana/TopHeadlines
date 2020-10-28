//
//  THError.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import Foundation

enum THError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToAdd = "There was an error adding this article. Please try again."
    case alreadyOnList = "You've already added this article."
    case invalidJSON = "JSON parsing error"
}

