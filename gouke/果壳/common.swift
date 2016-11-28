//
//  common.swift
//  果壳
//
//  Created by qianfeng on 2016/10/22.
//  Copyright © 2016年 张冬. All rights reserved.
//

import Foundation
import UIKit
let screenWidth=UIScreen.mainScreen().bounds.width
let screenHeight=UIScreen.mainScreen().bounds.height







//接口
let recommendUrl="http://www.guokr.com/apis/flowingboard/item/handpick_carousel.json"
let allUrl="http://www.guokr.com/apis/handpick/v2/article.json?limit=20&retrieve_type=by_offset&ad=1&offset=%d"
let Url="http://www.guokr.com/apis/handpick/v2/article.json?limit=20&retrieve_type=by_offset&ad=1&offset=%d&category=%@"
let groupUrl="http://www.guokr.com/apis/handpick/v2/article.json?source=%@&limit=20&retrieve_type=by_source&offset=%d"
let hotReplyUrl="http://www.guokr.com/apis/handpick/reply.json?article_id=%@&retrieve_type=by_hot_replies"

let replyListUrl="http://www.guokr.com/apis/handpick/reply.json?article_id=%@&offset=0&limit=20"

let detailRecommendUrl="http://www.guokr.com/apis/handpick/v2/article.json?limit=3&retrieve_type=by_recommend"
let keywordsUrl="http://www.guokr.com/apis/flowingboard/flowingboard.json?name=handpick_search_keywords"
let searchUrl="http://www.guokr.com/apis/handpick/search.json?offset=%@&limit=20&wd=%@"
let searchListDetailUrl="http://www.guokr.com/apis/handpick/v2/article.json?pick_id=%@"