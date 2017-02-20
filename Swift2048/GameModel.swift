//
//  GameModel.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/24.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class GameModel {
    
    // MARK: - Properties
    
    /// 维度
    var dimension: Int = 0
    /// 方块数字数组
    var tiles: Array<Int>
    /// 修改过的方块数字数组
    var mtiles: Array<Int>
    /// 过关的最大数字
    var maxNumber: Int = 0
    
    var scoreDelegate: ScoreViewProtocol
    var bestScoreDelegate: ScoreViewProtocol
    
    /// 分数
    var score: Int = 0
    /// 最高分
    var bestScore: Int = 0
    
    // MARK: - Custom initializers
    
    init(dimension: Int, maxNumber: Int, score: ScoreViewProtocol, bestScore: ScoreViewProtocol) {
        self.dimension = dimension
        self.maxNumber = maxNumber
        self.scoreDelegate = score
        self.bestScoreDelegate = bestScore
        self.tiles = Array<Int>(repeating: 0, count: self.dimension * self.dimension)
        self.mtiles = Array<Int>(repeating: 0, count: self.dimension * self.dimension)
    }
    
    func initTiles() {
        self.tiles = Array<Int>(repeating: 0, count: self.dimension * self.dimension)
        self.mtiles = Array<Int>(repeating: 0, count: self.dimension * self.dimension)
    }
    
    // MARK: - Additional Helpers
    
    /// 设置某个位置的值
    ///
    /// - Parameters:
    ///   - row: 行
    ///   - col: 列
    ///   - value: 值
    /// - Returns: false 有值；true 无值
    func setPosition(row: Int, col: Int, value: Int) -> Bool {
        assert(row >= 0 && row < dimension)
        assert(col >= 0 && col < dimension)
        let index = row * self.dimension + col
        let valueTemp = tiles[index]
        // 有值
        if valueTemp > 0 {
            print("该位置已经有值了")
            return false
        }
        tiles[index] = value
        return true
    }
    
    /// 检测剩余的空位置
    ///
    /// - Returns: 空位置数组
    func emptyPosition() -> Array<Int> {
        var emptyArray = Array<Int>()
        for i in 0 ..< (dimension * dimension) {
            if (tiles[i] == 0) {
                emptyArray.append(i)
            }
        }
        return emptyArray
    }
    
    /// 判断方块地图是否满了
    ///
    /// - Returns: true,地图满了；false，地图未满
    func isFull() -> Bool {
        if emptyPosition().count == 0 {
            return true
        }
        return false
    }
    
    
    /// 复制到MTiles
    func copyToMTiles() {
        for i in 0 ..< dimension * dimension {
            mtiles[i] = tiles[i]
        }
    }
    
    /// 从MTiles复制
    func copyFromMTiles() {
        for i in 0 ..< dimension * dimension {
            tiles[i] = mtiles[i]
        }
    }

    // 向上重排
    func reflowUp() {
        copyToMTiles()
        var index : Int
        for temp in 1 ... self.dimension - 1 {
            let i = dimension - temp
            for j in 0 ..< dimension {
                index = i * dimension + j
                // 如果当前行有值，上一行没值
                if mtiles[index] > 0 && mtiles[index - dimension] == 0 {
                    mtiles[index - dimension] = mtiles[index]
                    mtiles[index] = 0
                    // 后面行补上
                    while index + dimension < mtiles.count {
                        if mtiles[index + dimension] > 0 && mtiles[index] == 0 {
                            mtiles[index] = mtiles[index + dimension]
                            mtiles[index + dimension] = 0
                        }
                        index += dimension
                    }
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向下重排
    func reflowDown() {
        copyToMTiles()
        var index : Int
        for temp in 0 ..< self.dimension - 1 {
            let i = temp
            for j in 0 ... dimension - 1 {
                index = i * dimension + j
                // 如果当前行有值，下一行没值
                if mtiles[index] > 0 && mtiles[index + dimension] == 0 {
                    mtiles[index + dimension] = mtiles[index]
                    mtiles[index] = 0
                    // 后面行补上
                    while index - dimension >= 0 {
                        if mtiles[index - dimension] > 0 && mtiles[index] == 0 {
                            mtiles[index] = mtiles[index - dimension]
                            mtiles[index - dimension] = 0
                        }
                        index -= dimension
                    }
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向右重排
    func reflowRight() {
        copyToMTiles()
        var index : Int
        for temp in 0 ... self.dimension - 1 {
            let i = temp
            for j in 0 ..< dimension - 1 {
                index = i * dimension + j
                // 如果当前列有值，下一列没值
                if mtiles[index] > 0 && mtiles[index + 1] == 0 {
                    mtiles[index + 1] = mtiles[index]
                    mtiles[index] = 0
                    // 后面行补上
                    while index - 1 >= i * dimension {
                        if mtiles[index - 1] > 0 && mtiles[index] == 0 {
                            mtiles[index] = mtiles[index - 1]
                            mtiles[index - 1] = 0
                        }
                        index -= 1
                    }
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向左重排
    func reflowLeft() {
        copyToMTiles()
        var index : Int
        for temp in 0 ... self.dimension - 1 {
            let i = temp
            for j in 1 ... dimension - 1 {
                index = i * dimension + (dimension - j)
                // 如果当前列有值，前一列没值
                if mtiles[index] > 0 && mtiles[index - 1] == 0 {
                    mtiles[index - 1] = mtiles[index]
                    mtiles[index] = 0
                    // 后面行补上
                    while index + 1 < (i + 1) * dimension  {
                        if mtiles[index + 1] > 0 && mtiles[index] == 0 {
                            mtiles[index] = mtiles[index + 1]
                            mtiles[index + 1] = 0
                        }
                        index += 1
                    }
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向上合并
    func mergeUp() {
        copyToMTiles()
        var index : Int
        for temp in 1 ... self.dimension - 1 {
            let i = dimension - temp
            for j in 0 ..< dimension {
                index = i * dimension + j
                // 当前行和上一行相同，则合并到上一行
                if mtiles[index] > 0 && mtiles[index] == mtiles[index - dimension] {
                    mtiles[index - dimension] = mtiles[index - dimension] * 2
                    changeScore(s: mtiles[index - dimension] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向下合并
    func mergeDown() {
        copyToMTiles()
        var index : Int
        for temp in 0 ..< self.dimension - 1 {
            let i = temp
            for j in 0 ... dimension - 1 {
                index = i * dimension + j
                
                if mtiles[index] > 0 && mtiles[index] == mtiles[index + dimension] {
                    mtiles[index + dimension] = mtiles[index + dimension] * 2
                    changeScore(s: mtiles[index + dimension] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向右合并
    func mergeRight() {
        copyToMTiles()
        var index : Int
        for temp in 0 ... self.dimension - 1 {
            let i = temp
            for j in 0 ..< dimension - 1 {
                index = i * dimension + j
                // 如果当前列有值，下一列没值
                if mtiles[index] > 0 && mtiles[index] == mtiles[index + 1] {
                    mtiles[index + 1] = mtiles[index + 1] * 2
                    changeScore(s: mtiles[index + 1] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMTiles()
    }
    
    // 向左合并
    func mergeLeft() {
        copyToMTiles()
        var index : Int
        for temp in 0 ... self.dimension - 1 {
            let i = temp
            for j in 1 ... dimension - 1 {
                index = i * dimension + (dimension - j)
                // 如果当前列有值，前一列没值
                if mtiles[index] > 0 && mtiles[index] == mtiles[index - 1] {
                    mtiles[index - 1] = mtiles[index - 1] * 2
                    changeScore(s: mtiles[index - 1] * 2)
                    mtiles[index] = 0
                }
            }
        }
        copyFromMTiles()
    }
    
    /// 判断游戏是否成功
    ///
    /// - Returns: true，游戏成功；false，游戏未成功
    func isSuccess() -> Bool {
        for i in 0 ..< tiles.count {
            if tiles[i] >= maxNumber {
                return true
            }
        }
        return false
    }
    
    /// 检查垂直方向上有没有相同的元素
    ///
    /// - Returns: true，有相同元素；false，无相同元素
    func checkVertical() -> Bool {
        var index : Int
        for i in 0 ... dimension - 1 {
            for j in 0 ..< dimension - 1 {
                index = j * dimension + i
                if tiles[index] == tiles[index + dimension] {
                    return true
                }
            }
        }
        return false
    }
    
    /// 检查水平方向上有没有相同的元素
    ///
    /// - Returns: true，有相同元素；false，无相同元素
    func checkHorizon() -> Bool {
        var index : Int
        for i in 0 ... dimension - 1 {
            for j in 0 ..< dimension - 1 {
                index = i * dimension + j
                if tiles[index] == tiles[index + 1] {
                    return true
                }
            }
        }
        return false
    }
    
    /// 判断游戏是否可继续进行
    ///
    /// - Returns: true，可以继续进行；false，游戏无路可走
    func isFailure() -> Bool {
        if isFull() {
            if !checkVertical() && !checkHorizon() {
                return true
            }
        }
        return false
    }
    
    
    /// 修改分数
    ///
    /// - Parameter s: 新加的分数
    func changeScore(s: Int) {
        score += s
        bestScore = Int(UserDefaults.standard.integer(forKey: "BestScore"))
        if bestScore < score {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: "BestScore")
        }
        scoreDelegate.changeScore(value: score)
        bestScoreDelegate.changeScore(value: bestScore)
    }
}
