//
//	EnglishWord.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class EnglishWord : Decodable{

	var ARABIC_WORD_ID : String?
	var CONJUGATION : Int?
	var FEMININE : String?
	var FEMININE_PLURAL : String?
	var ID : String?
	var NOTE1 : String?
	var NOTE2 : String?
	var NOTE3 : String?
	var NOTE4 : String?
	var PART_OF_SPEECH : Int?
	var PLURAL : String?
	var ROOT : String?
	var WORD : String?

}

enum QuantumValue: Decodable {
    
    case int(Int), string(String)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw QuantumError.missingValue
    }
    enum QuantumError:Error {
        case missingValue
    }
}
