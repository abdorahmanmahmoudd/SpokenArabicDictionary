//
//	Conjugation.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Conjugation : NSObject, NSCoding{

	var aNA : String!
	var cONJUGATIONTYPE : String!
	var fEMALEPL : AnyObject!
	var fEMALES : AnyObject!
	var hIYYE : String!
	var hUMME : String!
	var hUWWE : String!
	var iD : String!
	var iHNA : String!
	var iNTE : String!
	var iNTI : String!
	var iNTU : String!
	var mALEPL : AnyObject!
	var mALES : AnyObject!
	var wORDID : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		aNA = dictionary["ANA"] as? String
		cONJUGATIONTYPE = dictionary["CONJUGATION_TYPE"] as? String
		fEMALEPL = dictionary["FEMALE_PL"] as AnyObject
		fEMALES = dictionary["FEMALE_S"] as AnyObject
		hIYYE = dictionary["HIYYE"] as? String
		hUMME = dictionary["HUMME"] as? String
		hUWWE = dictionary["HUWWE"] as? String
		iD = dictionary["ID"] as? String
		iHNA = dictionary["IHNA"] as? String
		iNTE = dictionary["INTE"] as? String
		iNTI = dictionary["INTI"] as? String
		iNTU = dictionary["INTU"] as? String
		mALEPL = dictionary["MALE_PL"] as AnyObject
		mALES = dictionary["MALE_S"] as AnyObject
		wORDID = dictionary["WORD_ID"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if aNA != nil{
			dictionary["ANA"] = aNA
		}
		if cONJUGATIONTYPE != nil{
			dictionary["CONJUGATION_TYPE"] = cONJUGATIONTYPE
		}
		if fEMALEPL != nil{
			dictionary["FEMALE_PL"] = fEMALEPL
		}
		if fEMALES != nil{
			dictionary["FEMALE_S"] = fEMALES
		}
		if hIYYE != nil{
			dictionary["HIYYE"] = hIYYE
		}
		if hUMME != nil{
			dictionary["HUMME"] = hUMME
		}
		if hUWWE != nil{
			dictionary["HUWWE"] = hUWWE
		}
		if iD != nil{
			dictionary["ID"] = iD
		}
		if iHNA != nil{
			dictionary["IHNA"] = iHNA
		}
		if iNTE != nil{
			dictionary["INTE"] = iNTE
		}
		if iNTI != nil{
			dictionary["INTI"] = iNTI
		}
		if iNTU != nil{
			dictionary["INTU"] = iNTU
		}
		if mALEPL != nil{
			dictionary["MALE_PL"] = mALEPL
		}
		if mALES != nil{
			dictionary["MALE_S"] = mALES
		}
		if wORDID != nil{
			dictionary["WORD_ID"] = wORDID
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aNA = aDecoder.decodeObject(forKey: "ANA") as? String
         cONJUGATIONTYPE = aDecoder.decodeObject(forKey: "CONJUGATION_TYPE") as? String
         fEMALEPL = aDecoder.decodeObject(forKey: "FEMALE_PL") as AnyObject
         fEMALES = aDecoder.decodeObject(forKey: "FEMALE_S") as AnyObject
         hIYYE = aDecoder.decodeObject(forKey: "HIYYE") as? String
         hUMME = aDecoder.decodeObject(forKey: "HUMME") as? String
         hUWWE = aDecoder.decodeObject(forKey: "HUWWE") as? String
         iD = aDecoder.decodeObject(forKey: "ID") as? String
         iHNA = aDecoder.decodeObject(forKey: "IHNA") as? String
         iNTE = aDecoder.decodeObject(forKey: "INTE") as? String
         iNTI = aDecoder.decodeObject(forKey: "INTI") as? String
         iNTU = aDecoder.decodeObject(forKey: "INTU") as? String
         mALEPL = aDecoder.decodeObject(forKey: "MALE_PL") as AnyObject
         mALES = aDecoder.decodeObject(forKey: "MALE_S") as AnyObject
         wORDID = aDecoder.decodeObject(forKey: "WORD_ID") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if aNA != nil{
			aCoder.encode(aNA, forKey: "ANA")
		}
		if cONJUGATIONTYPE != nil{
			aCoder.encode(cONJUGATIONTYPE, forKey: "CONJUGATION_TYPE")
		}
		if fEMALEPL != nil{
			aCoder.encode(fEMALEPL, forKey: "FEMALE_PL")
		}
		if fEMALES != nil{
			aCoder.encode(fEMALES, forKey: "FEMALE_S")
		}
		if hIYYE != nil{
			aCoder.encode(hIYYE, forKey: "HIYYE")
		}
		if hUMME != nil{
			aCoder.encode(hUMME, forKey: "HUMME")
		}
		if hUWWE != nil{
			aCoder.encode(hUWWE, forKey: "HUWWE")
		}
		if iD != nil{
			aCoder.encode(iD, forKey: "ID")
		}
		if iHNA != nil{
			aCoder.encode(iHNA, forKey: "IHNA")
		}
		if iNTE != nil{
			aCoder.encode(iNTE, forKey: "INTE")
		}
		if iNTI != nil{
			aCoder.encode(iNTI, forKey: "INTI")
		}
		if iNTU != nil{
			aCoder.encode(iNTU, forKey: "INTU")
		}
		if mALEPL != nil{
			aCoder.encode(mALEPL, forKey: "MALE_PL")
		}
		if mALES != nil{
			aCoder.encode(mALES, forKey: "MALE_S")
		}
		if wORDID != nil{
			aCoder.encode(wORDID, forKey: "WORD_ID")
		}

	}

}
