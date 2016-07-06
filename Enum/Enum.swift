//
//  Enum.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/7/6.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation



/// 每周Top10的action的枚举
enum TOP10Action : String {
    /// 作者
    case TopArticleAuthor = "topArticleAuthor"
    /// 专栏
    case TopContents = "topContents"
}

/// 专栏格子ID的枚举
enum TOP10ArticleCellID: String{

    /// 排名1-3的格子identfier
    case TopActicleNormalCellReusedIdtentfier = "TopActicleNormalCellReusedIdtentfier"
    /// 其他的格子identfier
    case TopActicleOtherCellReusedIdtentfier = "TopActicleOtherCellReusedIdtentfier"
}




