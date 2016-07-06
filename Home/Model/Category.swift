//
//  Category.swift
//  HuaTianXiaoQi
//
//  Created by lc－mac on 16/6/30.
//  Copyright © 2016年 lc－mac. All rights reserved.
//

import Foundation


///所属类别
class Category: NSObject {
    // 专题创建时间
    var createDate : String?
    // 专题类型ID
    var id : String?
    // 专题类型名称
    var name : String?
    // 专题序号
    var order : Int?
    
    
    ///构造器
    init(dict:[String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    // MARK: - 序列化和反序列化
    private let createDate_Key = "createDate"
    private let id_Key = "id"
    private let name_Key = "name"
    private let order_Key = "order"
    
    ///序列化
    func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(createDate,forKey: createDate_Key)
        aCoder.encodeObject(id, forKey: id_Key)
        aCoder.encodeObject(order, forKey: order_Key)
        aCoder.encodeObject(name, forKey: name_Key)
    }
    ///反序列化
    required init?(coder aDecoder: NSCoder) {
        createDate = aDecoder.decodeObjectForKey(createDate_Key) as? String
        id =  aDecoder.decodeObjectForKey(id_Key) as? String
        order = aDecoder.decodeObjectForKey(order_Key) as? Int
        name = aDecoder.decodeObjectForKey(name_Key) as? String
    }
    
    //MARK:- 保存和获取所有分类的键
    ///保存和获取所有分类的键
    static let CategoriesKey = "Categorieskey"
    
    
    ///保存所有的分类  保存的时候先转为NSData
    class func saveCategories(categories:[Category]){
       
        //先转换为NSData  然后保存
        let data = NSKeyedArchiver.archivedDataWithRootObject(categories)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: Category.CategoriesKey)
    
    }
    /// 读取保存在本地所有的分类 读取出来后 转换为实体类数据
    class  func loadLocalCategories()->[Category]?{
    
        //读取出来后 转换为实体类数据
        if let array = NSUserDefaults.standardUserDefaults().objectForKey(Category.CategoriesKey){
          return NSKeyedUnarchiver.unarchiveObjectWithData(array as! NSData) as? [Category]
        }
        return nil
    
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}