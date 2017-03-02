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
            return String(firstChar).uppercased() + String(chars)
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
                .components(separatedBy: " ")
                .map { $0.upcaseInitial() }
                .reduce("", +)
        }

        return self
    }

    func phoneticLast() -> String {
        let SpecialLastName: [String: String] = [
            "柏": "bai",
            "鲍": "bao",
            "贲": "ben",
            "秘": "bi",
            "薄": "bo",
            "卜": "bu",
            "岑": "cen",
            "晁": "chao",
            "谌": "chen",
            "种": "chong",
            "褚": "chu",
            "啜": "chuai",
            "单": "chan",
            "郗": "chi",
            "邸": "di",
            "都": "du",
            "缪": "miao",
            "宓": "mi",
            "费": "fei",
            "苻": "fu",
            "睢": "sui",
            "区": "ou",
            "华": "hua",
            "庞": "pang",
            "查": "zha",
            "佘": "she",
            "仇": "qiu",
            "靳": "jin",
            "解": "xie",
            "繁": "po",
            "折": "she",
            "员": "yun",
            "祭": "zhai",
            "芮": "rui",
            "覃": "tan",
            "牟": "mou",
            "蕃": "pi",
            "戚": "qi",
            "瞿": "qu",
            "冼": "xian",
            "洗": "xian",
            "郤": "xi",
            "庹": "tuo",
            "彤": "tong",
            "佟": "tong",
            "妫": "gui",
            "句": "gou",
            "郝": "hao",
            "曾": "zeng",
            "乐": "yue",
            "蔺": "lin",
            "隽": "juan",
            "臧": "zang",
            "庾": "yu",
            "詹": "zhan",
            "禚": "zhuo",
            "迮": "ze",
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

    if let lastName = people.value(forProperty: kABLastNameProperty) as? String {
        _ = try? people.setValue(
            lastName.phoneticLast().phonetic(),
            forProperty: kABLastNamePhoneticProperty,
            error: ()
        )
        print(lastName, lastName.phoneticLast().phonetic(), separator: "->", terminator: ", ")
    }

    if let firstName = people.value(forProperty: kABFirstNameProperty) as? String {
        _ = try? people.setValue(
            firstName.phonetic(),
            forProperty: kABFirstNamePhoneticProperty,
            error: ()
        )
        print(firstName, firstName.phonetic(), separator: "->", terminator: " | ")
    }
}
ab.save()
