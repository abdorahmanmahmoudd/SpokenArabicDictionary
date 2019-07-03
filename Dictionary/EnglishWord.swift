//
//	EnglishWord.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class EnglishWord : NSObject, NSCoding{

	var aRABICWORDID : String!
	var cONJUGATION : AnyObject!
	var fEMININE : AnyObject!
	var fEMININEPLURAL : AnyObject!
	var iD : String!
	var nOTE1 : AnyObject!
	var nOTE2 : AnyObject!
	var nOTE3 : AnyObject!
	var nOTE4 : AnyObject!
	var pARTOFSPEECH : AnyObject!
	var pLURAL : AnyObject!
	var rOOT : AnyObject!
	var wORD : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		aRABICWORDID = dictionary["ARABIC_WORD_ID"] as? String
        cONJUGATION = dictionary["CONJUGATION"] as AnyObject
        fEMININE = dictionary["FEMININE"] as AnyObject
        fEMININEPLURAL = dictionary["FEMININE_PLURAL"] as AnyObject
		iD = dictionary["ID"] as? String
		nOTE1 = dictionary["NOTE1"] as AnyObject
		nOTE2 = dictionary["NOTE2"] as AnyObject
		nOTE3 = dictionary["NOTE3"] as AnyObject
		nOTE4 = dictionary["NOTE4"] as AnyObject
		pARTOFSPEECH = dictionary["PART_OF_SPEECH"] as AnyObject
		pLURAL = dictionary["PLURAL"] as AnyObject
		rOOT = dictionary["ROOT"] as AnyObject
		wORD = dictionary["WORD"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if aRABICWORDID != nil{
			dictionary["ARABIC_WORD_ID"] = aRABICWORDID
		}
		if cONJUGATION != nil{
			dictionary["CONJUGATION"] = cONJUGATION
		}
		if fEMININE != nil{
			dictionary["FEMININE"] = fEMININE
		}
		if fEMININEPLURAL != nil{
			dictionary["FEMININE_PLURAL"] = fEMININEPLURAL
		}
		if iD != nil{
			dictionary["ID"] = iD
		}
		if nOTE1 != nil{
			dictionary["NOTE1"] = nOTE1
		}
		if nOTE2 != nil{
			dictionary["NOTE2"] = nOTE2
		}
		if nOTE3 != nil{
			dictionary["NOTE3"] = nOTE3
		}
		if nOTE4 != nil{
			dictionary["NOTE4"] = nOTE4
		}
		if pARTOFSPEECH != nil{
			dictionary["PART_OF_SPEECH"] = pARTOFSPEECH
		}
		if pLURAL != nil{
			dictionary["PLURAL"] = pLURAL
		}
		if rOOT != nil{
			dictionary["ROOT"] = rOOT
		}
		if wORD != nil{
			dictionary["WORD"] = wORD
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aRABICWORDID = aDecoder.decodeObject(forKey: "ARABIC_WORD_ID") as? String
         cONJUGATION = aDecoder.decodeObject(forKey: "CONJUGATION") as AnyObject
         fEMININE = aDecoder.decodeObject(forKey: "FEMININE") as AnyObject
         fEMININEPLURAL = aDecoder.decodeObject(forKey: "FEMININE_PLURAL") as AnyObject
         iD = aDecoder.decodeObject(forKey: "ID") as? String
         nOTE1 = aDecoder.decodeObject(forKey: "NOTE1") as AnyObject
         nOTE2 = aDecoder.decodeObject(forKey: "NOTE2") as AnyObject
         nOTE3 = aDecoder.decodeObject(forKey: "NOTE3") as AnyObject
         nOTE4 = aDecoder.decodeObject(forKey: "NOTE4") as AnyObject
         pARTOFSPEECH = aDecoder.decodeObject(forKey: "PART_OF_SPEECH") as AnyObject
         pLURAL = aDecoder.decodeObject(forKey: "PLURAL") as AnyObject
         rOOT = aDecoder.decodeObject(forKey: "ROOT") as AnyObject
         wORD = aDecoder.decodeObject(forKey: "WORD") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if aRABICWORDID != nil{
			aCoder.encode(aRABICWORDID, forKey: "ARABIC_WORD_ID")
		}
		if cONJUGATION != nil{
			aCoder.encode(cONJUGATION, forKey: "CONJUGATION")
		}
		if fEMININE != nil{
			aCoder.encode(fEMININE, forKey: "FEMININE")
		}
		if fEMININEPLURAL != nil{
			aCoder.encode(fEMININEPLURAL, forKey: "FEMININE_PLURAL")
		}
		if iD != nil{
			aCoder.encode(iD, forKey: "ID")
		}
		if nOTE1 != nil{
			aCoder.encode(nOTE1, forKey: "NOTE1")
		}
		if nOTE2 != nil{
			aCoder.encode(nOTE2, forKey: "NOTE2")
		}
		if nOTE3 != nil{
			aCoder.encode(nOTE3, forKey: "NOTE3")
		}
		if nOTE4 != nil{
			aCoder.encode(nOTE4, forKey: "NOTE4")
		}
		if pARTOFSPEECH != nil{
			aCoder.encode(pARTOFSPEECH, forKey: "PART_OF_SPEECH")
		}
		if pLURAL != nil{
			aCoder.encode(pLURAL, forKey: "PLURAL")
		}
		if rOOT != nil{
			aCoder.encode(rOOT, forKey: "ROOT")
		}
		if wORD != nil{
			aCoder.encode(wORD, forKey: "WORD")
		}

	}

}
