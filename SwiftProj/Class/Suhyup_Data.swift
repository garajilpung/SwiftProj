//
//  suhyup.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/02/17.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import Foundation
/*
 
 공통 부분이라 함수에서 처리
struct SUHYUP_DATA_MSG : Decodable {
    var _msg_ : SUHYUP_DATA
}

struct SUHYUP_DATA : Decodable {
    var _common_ : SUHYUP_COMMON
    var _body_ : String?
}
*/

struct SUHYUP_COMMON : Decodable {
    let errorCode : String?
    let resCode : String?
    
    enum CodingKeys: String, CodingKey {
        case resCode = "resCode"
        case errorCode = "error.code"
    }
    
    public func desc() {
        print("errorCode \(errorCode!)")
        print("errorCode \(resCode!)")
    }
}

struct BODY_GOODSDATA : Decodable{
    let ERROR_CODE : String
    let ERROR_MSG : String
    
    //popup data
    var BANNER_TITLE : String?
    var CHAN_DC_CD : String?
    var ENR_DTTM : String?
    
    var TSK_DC_CD : String?
    var SEQ_NO : String?
    var LINK_DC_CD : String?
    var LINK_DC_STUP_VAL : String?
    var POST_END_DTTM : String?
    var POST_GRP_CD : String?
    var POST_ST_DTTM : String?
    var IMG_FIL_NM : String?
    
    let IMG_URL_C : String
    let IMG_URL_D : String
    let IMG_URL_DP : String
    let IMG_URL_DS : String
    let IMG_URL_DW : String
    let IMG_URL_F : String
    let IMG_URL_FUND : String
    let IMG_URL_L : String
    
    let MENU_ID_C : String
    let MENU_ID_D : String
    let MENU_ID_DP : String
    let MENU_ID_DS : String
    let MENU_ID_DW : String
    let MENU_ID_F : String
    let MENU_ID_FUND : String
    let MENU_ID_L : String
    
    let REP_PRODCD_C : String
    let REP_PRODCD_D : String
    let REP_PRODCD_DP : String
    let REP_PRODCD_DS : String
    let REP_PRODCD_DW : String
    let REP_PRODCD_F : String
    let REP_PRODCD_L : String
    
    
    var INQ_OD : String?
    var LST_CHG_DTTM : String?
    var LST_CHG_ID : String?
    
    let TAB_ON : String
    let TAB_REC : String
    let prdCount : String
    
    var ROWNUM : String?
    var IMG_DESC : String?
    var RGSR_ID : String?
    
    let PRD_LIST: [Dictionary<String, String>]
    
    public func desc() {
        print("ERROR_CODE \(ERROR_CODE)")
        print("ERROR_MSG \(ERROR_MSG)")
    }
    
}

struct BODY_GOODSDATA_VM {
    enum GoodsData_GoodsIndex : Int {
        case dw = 0 // 입출금
        case dp // 예금
        case ds // 적금
        case loan // 대출
        case card // 카드
        case fori // 외환
        case fund // 펀드
        case d // 일반
    }
    
    let goodsData : BODY_GOODSDATA
}


extension BODY_GOODSDATA_VM {
    var nCountX : Int {
        return 2
    }
    
    var arrMenuID : [String] {
        return [goodsData.MENU_ID_DW, goodsData.MENU_ID_DP, goodsData.MENU_ID_DS, goodsData.MENU_ID_L, goodsData.MENU_ID_C, goodsData.MENU_ID_F, goodsData.MENU_ID_FUND, goodsData.MENU_ID_D]
    }
    
    var arrImgURL : [String] {
        let url1 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_C.getURLDecdoing())
        let url2 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_D.getURLDecdoing())
        let url3 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_DP.getURLDecdoing())
        let url4 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_DS.getURLDecdoing())
        let url5 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_DW.getURLDecdoing())
        let url6 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_F.getURLDecdoing())
        let url7 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_FUND.getURLDecdoing())
        let url8 : String = String.init(format: "https://mtest.suhyup-bank.com:9190/%@", goodsData.IMG_URL_L.getURLDecdoing())
        
        return [url1, url2, url3, url4, url5, url6, url7, url8]
    }
    
    var arrProCD : [String] {
        return [goodsData.REP_PRODCD_DW, goodsData.REP_PRODCD_DP, goodsData.REP_PRODCD_DS, goodsData.REP_PRODCD_L, goodsData.REP_PRODCD_C, goodsData.REP_PRODCD_F, "", goodsData.REP_PRODCD_D]
    }
    
    var dicPopupData : Dictionary<String, String>? {
        guard let val1 = goodsData.CHAN_DC_CD else {
            return nil
        }

        guard let val2 = goodsData.TSK_DC_CD else {
            return nil
        }
        
        guard let val3 = goodsData.SEQ_NO else {
            return nil
        }
        
        guard let val4 = goodsData.LINK_DC_CD else {
            return nil
        }
        
        guard let val5 = goodsData.LINK_DC_STUP_VAL else {
            return nil
        }
        
        guard let val6 = goodsData.POST_GRP_CD else {
            return nil
        }
        
        guard let val7 = goodsData.POST_ST_DTTM else {
            return nil
        }
        
        guard let val8 = goodsData.POST_END_DTTM else {
            return nil
        }
        
        guard let val9 = goodsData.IMG_FIL_NM else {
            return nil
        }
        
        guard let val10 = goodsData.BANNER_TITLE else {
            return nil
        }
        
        return ["CHAN_DC_CD":val1,
                "TSK_DC_CD":val2,
                "SEQ_NO":val3,
                "LINK_DC_CD":val4,
                "LINK_DC_STUP_VAL":val5,
                "POST_GRP_CD":val6,
                "POST_ST_DTTM":val7,
                "POST_END_DTTM":val8,
                "IMG_FIL_NM":val9,
                "BANNER_TITLE":val10
        ]
    }
    
    var arrDW : [Dictionary<String, String>] {
        var arr : [Dictionary<String, String>] = []
        
        for dic in goodsData.PRD_LIST {
            let gubunCode = dic["GUBUNCODE"]
            let subgubunCode = dic["GUBUNCODE_SUB"]
            
            if gubunCode == "01" && subgubunCode == "01" {
                arr.append(dic)
            }
        }
        return arr
    }
    
    
    func getGoodsList(_ gubun: GoodsData_GoodsIndex) -> [Dictionary<String, String>]  {
        var arr : [Dictionary<String, String>] = []
        
        for dic in goodsData.PRD_LIST {
            let gubunCode = dic["GUBUNCODE"]
            let subgubunCode = dic["GUBUNCODE_SUB"]
            
            if gubunCode == "01" && subgubunCode == "01" && gubun == .dw { // 입출금
                arr.append(dic)
            }else if gubunCode == "01" && subgubunCode == "02" && gubun == .dp { // 예금
                arr.append(dic)
            }else if gubunCode == "01" && subgubunCode == "03" && gubun == .ds  { // 적금
                arr.append(dic)
            }else if gubunCode == "02" && gubun == .loan { // 대출
                arr.append(dic)
            }else if gubunCode == "03" && gubun == .card { // 카드
                arr.append(dic)
            }else if gubunCode == "07" && gubun == .fori { // 외환
                arr.append(dic)
            }
        }
        
        return arr
    }
    
    func numberOfRowsInSectionDW() -> Int {
        return arrDW.count
    }
    
    func arrDWIndex(_ index: Int) -> Dictionary<String, String> {
        return arrDW[index]
    }
}

