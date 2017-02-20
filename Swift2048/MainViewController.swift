//
//  MainViewController.swift
//  Swift2048
//
//  Created by Sunhy on 16/12/21.
//  Copyright © 2016年 Sunhy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var imageView:UIImageView
    var reTryButton:UIButton
    
    // 数字格子的宽度
    var width : CGFloat = 58
    // 格子与格子的间隙
    var padding : CGFloat = 7
    // 保存背景图数据
    var backgrounds:Array<UIView>
    // 白色方块底图
    var whiteView : UIView
    // 分数标签
    var score : ScoreView
    // 最高分标签
    var bestScore : BestScoreView
    // 游戏数据模型
    var gameModel:GameModel
    
    var tiles : Dictionary<IndexPath, TileView>
    var tilesValue : Dictionary<IndexPath, Int>
    
    // 游戏方格维度
    var dimention:Int = 4{
        didSet {
            gameModel.dimension = dimention
        }
    }
    
    var maxNumber : Int = 2048 {
        didSet {
            gameModel.maxNumber = maxNumber
        }
    }
    
    enum AnimationSlipType {
        case none   // 无动画
        case new    // 新出现动画
        case merge  // 合并动画
    }
    
    init() {
        score = ScoreView()
        bestScore = BestScoreView()
        self.gameModel = GameModel(dimension: self.dimention, maxNumber: self.maxNumber, score: self.score, bestScore: self.bestScore)
        self.imageView = UIImageView()
        self.reTryButton = UIButton()
        self.backgrounds = Array<UIView>()
        self.whiteView = UIView()
        tiles = Dictionary<IndexPath, TileView>()
        tilesValue = Dictionary<IndexPath, Int>()
        super.init(nibName: nil, bundle: nil)
    }
    
    func setupTitleView() {
        imageView.image = UIImage(named:"title")
        imageView.frame = CGRect(x: 22, y: 96, width: 69, height: 69)
        self.view.addSubview(self.imageView)
    }
    
    func setupRetryBtn() {
        reTryButton = ControlView.createButton(#selector(MainViewController.restart), sender: self)
        reTryButton.frame = CGRect(x: 290, y: 96, width: 60, height: 60)
        self.view.addSubview(reTryButton)
    }
    
    // 创建游戏面板底图
    func setupWhiteView() {
        let rect = UIScreen.main.bounds
        let w:CGFloat = rect.width
        let backWidth = width * CGFloat(dimention) + padding * CGFloat(dimention - 1) + 20
        let backX = (w - backWidth) / 2
        self.whiteView.frame = CGRect(x: backX, y: 208, width: backWidth, height: backWidth)
        self.whiteView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.6)
        self.view.addSubview(self.whiteView)
    }
    
    // 创建方格
    func setupBackground() {
        setupWhiteView()
        var x:CGFloat = 10
        var y:CGFloat = 10
        for _ in 0..<dimention {
            y = 10
            for _ in 0..<dimention {
                let backgroundView = UIView(frame: CGRect(x: x, y: y, width: width, height: width))
                backgroundView.backgroundColor = UIColor(red: 210/255.0, green: 210/255.0, blue: 210/255.9, alpha: 1.0)
                backgroundView.layer.cornerRadius = 4
                self.whiteView.addSubview(backgroundView)
                backgrounds.append(backgroundView)
                y += padding + width
            }
            x += padding + width
        }
    }
    
    func setupScoreLabels() {
        score.frame.origin.x = 120
        score.frame.origin.y = 96
        self.view.addSubview(score)
        bestScore.frame.origin.x = 120
        bestScore.frame.origin.y = 132
        self.view.addSubview(bestScore)
    }
    
    func setupSwipeGestures() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.upSwipe))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(upSwipe)
        // 向下
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.downSwipe))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(downSwipe)
        // 向右
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.rightSwipe))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        // 向左
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.leftSwipe))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    func upSwipe() {
        if !gameModel.isSuccess() {
            printTiles(array: gameModel.tiles)
            gameModel.reflowUp()
            gameModel.mergeUp()
            gameModel.reflowUp()
            printTiles(array: gameModel.tiles)
            print("up")
            initUI()
            genRandom()
        }
    }
    
    func downSwipe() {
        if !gameModel.isSuccess() {
            printTiles(array: gameModel.tiles)
            gameModel.reflowDown()
            gameModel.mergeDown()
            gameModel.reflowDown()
            printTiles(array: gameModel.tiles)
            print("down")
            initUI()
            genRandom()
        }
    }
    
    func rightSwipe() {
        if !gameModel.isSuccess() {
            printTiles(array: gameModel.tiles)
            gameModel.reflowRight()
            gameModel.mergeRight()
            gameModel.reflowRight()
            printTiles(array: gameModel.tiles)
            print("right")
            initUI()
            genRandom()
        }
    }
    
    func leftSwipe() {
        if !gameModel.isSuccess() {
            printTiles(array: gameModel.tiles)
            gameModel.reflowLeft()
            gameModel.mergeLeft()
            gameModel.reflowLeft()
            printTiles(array: gameModel.tiles)
            print("left")
            initUI()
            genRandom()
        }
    }
    
    func restart() {
        resetUI()
        gameModel.initTiles()
        for _ in 0 ... 1 {
            genRandom()
        }
    }
    
    func genRandom() {
        let randomNum = Int(arc4random_uniform(10))
        var seed:Int = 2
        if randomNum == 1 {
            seed = 4
        }
        let col = Int(arc4random_uniform(UInt32(dimention)))
        let row = Int(arc4random_uniform(UInt32(dimention)))
        if gameModel.isFull() {
            print("满了")
            return
        }
        if gameModel.setPosition(row: row, col: col, value: seed) == false {
            genRandom()
            return
        }
        if gameModel.isFailure() {
            let alert = UIAlertController(title: "游戏结束", message: "失败了", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action : UIAlertAction) -> Void in
                self.restart()
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        insertTile((row, col), value: seed, aType: AnimationSlipType.new)
    }
    
    func insertTile(_ pos:(Int, Int), value:Int, aType:AnimationSlipType) {
        let (row, col) = pos
        let x = 10 + CGFloat(col) * (width + padding)
        let y = 10 + CGFloat(row) * (width + padding)
        // 插入数字块
        let tile = TileView(pos: CGPoint(x: x, y: y), width: width, value: value)
        tile.layer.cornerRadius = 4
        self.whiteView.addSubview(tile)
        self.view.bringSubview(toFront: tile)
        
        let indexPath = IndexPath(row: row, section: col)
        // 字面量写法？
        self.tiles.updateValue(tile, forKey: indexPath)
        self.tilesValue.updateValue(value, forKey: indexPath)
        
        if aType == AnimationSlipType.none {
            return
        } else if aType == AnimationSlipType.new {
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
        } else if aType == AnimationSlipType.merge {
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: 0.8, y: 0.8))
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions(), animations: {
            () -> Void in
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
        }, completion: {
            (finished : Bool) -> Void in
            UIView.animate(withDuration: 0.08, animations: {
                () -> Void in
                tile.layer.setAffineTransform(CGAffineTransform.identity)
            })
        })
    }
    
    func printTiles(array:Array<Int>) {
        for i in 0..<array.count {
            if (i+1) % dimention == 0 {
                print(array[i])
            } else {
                print(array[i], separator: "", terminator: "\t")
            }
        }
    }
    
    func resetUI() {
        for (_, tile) in tiles {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepingCapacity: true)
        tilesValue.removeAll(keepingCapacity: true)
        for backgound in backgrounds {
            backgound.removeFromSuperview()
        }
        setupBackground()
        score.changeScore(value: 0)
        gameModel.score = 0
    }
    
    func initUI() {
        var indexPath : IndexPath
        var tile : TileView
        for i in 0 ..< dimention {
            for j in 0 ..< dimention {
                let index = i * dimention + j
                indexPath = IndexPath(row: i, section: j)
                // model有值，而view没值
                if gameModel.tiles[index] != 0 && tilesValue.index(forKey: indexPath) == nil {
                    self.insertTile((i, j), value: gameModel.tiles[index], aType: AnimationSlipType.merge)
                }
                
                // model没值，而view有值
                if gameModel.tiles[index] == 0 && tilesValue.index(forKey: indexPath) != nil {
                    tile = tiles[indexPath]!
                    tile.removeFromSuperview()
                    tiles.removeValue(forKey: indexPath)
                    tilesValue.removeValue(forKey: indexPath)
                }
                
                // model 有值，view有值，值不同
                if gameModel.tiles[index] > 0 && tilesValue.index(forKey: indexPath) != nil {
                    if gameModel.tiles[index] != tilesValue[indexPath] {
                        tile = tiles[indexPath]!
                        tile.removeFromSuperview()
                        tiles.removeValue(forKey: indexPath)
                        tilesValue.removeValue(forKey: indexPath)
                        insertTile((i, j), value: gameModel.tiles[index], aType: AnimationSlipType.merge)
                    }
                }
                
            }
        }
        
        if gameModel.isSuccess() {
            let alertVC = UIAlertController(title: "恭喜过关", message: "过关", preferredStyle: UIAlertControllerStyle.alert)
            
            let makeSureBtn = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: {
                (action:UIAlertAction) -> Void in
            })
            
            let retryBtn = UIAlertAction(title: "再玩一次", style: UIAlertActionStyle.default, handler: {
                (action:UIAlertAction) -> Void in
                self.restart()
            })
            alertVC.addAction(makeSureBtn)
            alertVC.addAction(retryBtn)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        setupTitleView()
        setupRetryBtn()
        setupBackground()
        setupSwipeGestures()
        setupScoreLabels()
        gameModel.changeScore(s: 0)
        // 重复？
        self.gameModel = GameModel(dimension: self.dimention, maxNumber: self.maxNumber, score: score, bestScore: bestScore)
        for _ in 0 ... 1 {
            genRandom()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
