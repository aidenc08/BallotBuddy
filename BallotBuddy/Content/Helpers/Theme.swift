//
//  Theme.swift
//  BallotBuddy
//
//  Created by Caden on 8/29/24.
//


import UIKit

var theme: Bool = true // light = true, dark = false

/*let globalBackground: UIColor = UIColor(hex: "121212")
let globalBackgroundAccent: UIColor = UIColor(hex: "212121")
let globalTextColor: UIColor = UIColor(hex: "ebebeb")
let globalAccent: UIColor = UIColor(hex: "EA6461")
let globalTextColorDark: UIColor = UIColor(hex: "adadad")
 */

let globalBackground: UIColor = theme ? UIColor(hex: "ffffff") : UIColor(hex: "121212")
let globalBackgroundAccent: UIColor = theme ? UIColor(hex: "ebebeb") : UIColor(hex: "212121")
let globalTextColor: UIColor = theme ? UIColor(hex: "363636") : UIColor(hex: "ebebeb")
let globalAccent: UIColor = UIColor(hex: "EA6461")
let globalTextColorDark: UIColor = theme ? UIColor(hex: "595959") : UIColor(hex: "adadad")
