//
//  main.swift
//  PhoneticContacts
//
//  Created by Lex on 2/7/16.
//  Copyright © 2016 Lex Tang. All rights reserved.
//

import Foundation
import AddressBook

extension String {

    func upcaseInitial() -> String {
        var chars = characters
        if let firstChar = chars.popFirst().map({ String($0) }) {
            return String(firstChar).uppercaseString + String(chars)
        }
        return ""
    }

    func phonetic() -> String {
        let src = NSMutableString(string: self) as CFMutableString
        CFStringTransform(src, nil, kCFStringTransformMandarinLatin, false)

        // Transform NínHǎo to NinHao
        CFStringTransform(src, nil, kCFStringTransformStripCombiningMarks, false)

        let s = src as String
        if s != self {
            return s
                .componentsSeparatedByString(" ")
                .map { $0.upcaseInitial() }
                .reduce("", combine: +)
        }

        return self
    }

    func phoneticLast() -> String {
        let SpecialLastName: [String: String] = [
            "秘": "bi",
            "薄": "bo",
            "卜": "bu",
            "种": "chong",
            "重": "chong",
            "盖": "ge",
            "阚": "kan",
            "单": "shan",
            "都": "du",
            "缪": "miao",
            "费": "fei", // or "bi"
            "区": "ou",
            "查": "zha",
            "仇": "qiu",
            "解": "xie",
            "朴": "piao",
            "繁": "po",
            "折": "she",
            "员": "yun",
            "祭": "zhai",
            "蕃": "bo",
            "洗": "xian",
            "彤": "tong",
            "句": "gou",
            "曾": "zeng",
            "乐": "yue", // or "le"
            "沈": "shen",
            "沉": "shen",
            "尉迟": "yuchi",
            "长孙": "zhangsun",
            "中行": "zhonghang",
            "万俟": "moqi",
            "单于": "chanyu"
        ]

        if let specialLastName = SpecialLastName[self] {
            return specialLastName.upcaseInitial()
        }
        return self
    }

}

let ab = ABAddressBook()
ab.people().forEach {
    guard let people = $0 as? ABPerson else {
        return
    }

    if let lastName = people.valueForProperty(kABLastNameProperty) as? String {
        _ = try? people.setValue(
            lastName.phoneticLast().phonetic(),
            forProperty: kABLastNamePhoneticProperty,
            error: ()
        )
        print(lastName, lastName.phoneticLast().phonetic(), separator: "->", terminator: ", ")
    }

    if let firstName = people.valueForProperty(kABFirstNameProperty) as? String {
        _ = try? people.setValue(
            firstName.phonetic(),
            forProperty: kABFirstNamePhoneticProperty,
            error: ()
        )
        print(firstName, firstName.phonetic(), separator: "->", terminator: " | ")
    }
}
ab.save()
