//
//  GameManager.swift
//  NetworkedBattleship
//
//  Created by Hayden Shelton on 3/29/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation
class ServerGameManager
{
    //the server gives us an array of JSON objects which represent games
    private var serverGames: [Int: serverGame] = [:] //order created to server game
    var globalCounter = 0
    var myGamesDictionary: NSMutableArray = [] //this is a dictionary of gameIDs to playerIDs
   
    
    init()
    {
     //TODO: load the gameid to player id dictionary from file
    }
    
    
 
    
    //checks to see if the game in question is one of your own
    func isMyGame(id: String) -> Bool
    {
        for var i = 0; i < myGamesDictionary.count; i++
        {
            let tempDict = myGamesDictionary[i] as NSDictionary
            if(tempDict["gameId"] as String == id)
            {
                return true
            }
        }
        return false
    }
    
    func getGameCount() -> Int
    {
        return serverGames.count
    }
    
    func getGameForCellAtIndex(index: Int) -> serverGame
    {
        return serverGames[index]!
    }
    
    func getGameForCellAtIndexForMyGames(index: Int) -> serverGame
    {
        var entry = myGamesDictionary[index] as NSDictionary
        
        //get the game id for the game
        var gameID: String = entry["gameId"] as String
       
       var sG = serverGame(_id: "0", _name: "", _status: "")
        let getURL: String = "http://battleship.pixio.com/api/v2/lobby/"+gameID
        let gameDetailURL: NSURL = NSURL(string: getURL)!
        
        let summaryData: NSData? = NSData(contentsOfURL: gameDetailURL)
        if(summaryData == nil)
        {
           return sG
        }
        let serializedGame: NSDictionary? = NSJSONSerialization.JSONObjectWithData(summaryData!, options: .allZeros, error: nil) as NSDictionary?
        
        if(serializedGame == nil)
        {
            return sG
        }
        sG.name = serializedGame!["name"] as String
        sG.status = serializedGame!["status"] as String
        sG.id = gameID
        return sG

    }
    
    func getServerParamsForGameAtIndex(index: Int) -> NSDictionary
    {
        var entry = myGamesDictionary[index] as NSDictionary
        return entry
    }
    
    func getMyGameCount() -> Int
    {
        return myGamesDictionary.count
    }
    func addserverGameToList(sv: serverGame)
    {
        var name: String = sv.name
        serverGames[globalCounter++] = sv
    }
    
    func createGame(gameName: String, playerName: String)
    {
        //this will hold the NSError if we can't create an NSDictionary from the server response
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://battleship.pixio.com/api/v2/lobby")!)
        request.HTTPMethod = "POST"
        let postString = "gameName=\(gameName)&playerName=\(playerName)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                println("error=\(error)")
                return
            }
            
            println("response = \(response)")
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            var json: NSDictionary? = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: &err) as NSDictionary?
            

            var responsePlayerID = json!["playerId"] as String
            var responseGameID = json!["gameId"] as String
            
        //once I create a game, I should save my player id and the game id
            let dictionaryEntry: NSDictionary = ["gameId": responseGameID, "playerId":responsePlayerID]
            self.myGamesDictionary.addObject(dictionaryEntry)
            self.writeGamesDictionaryToFile()
        }
        task.resume()
        loadGameIDsFromFile()
    }
    func joinGame(playerName: String, gameID: String)
    {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://battleship.pixio.com/api/v2/lobby/\(gameID)")!)
        request.HTTPMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let jsonObject: NSDictionary = ["playerName": playerName, "id": "gameID"]
        let requestDict = NSJSONSerialization.dataWithJSONObject(jsonObject, options: .allZeros, error: nil)
        request.HTTPBody = requestDict
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        let gameAttributions: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as NSDictionary
        println(gameAttributions)
        
        var idReturned = gameAttributions["playerId"] as String
        //once I join a game, I should save the game id and the player id
        let dictionaryEntry: NSDictionary = ["gameId": gameID, "playerId":idReturned]
        myGamesDictionary.addObject(dictionaryEntry)
        writeGamesDictionaryToFile()
        loadGameIDsFromFile()
    }
    
    func refreshGamesList()
    {
        refreshGamesList(0)
    }
    
    func refreshMyGamesList()
    {
       loadGameIDsFromFile()
    }
    //this function pulls in the games list from the server
    func refreshGamesList(offset: Int)
    {
        let gameListURL: NSURL = NSURL(string:"http://battleship.pixio.com/api/v2/lobby?offset=\(offset)&results=5000")!
        let gameListJson: NSData? = NSData(contentsOfURL: gameListURL)
        if(gameListJson == nil)
        {
            print("No Data at URL \(gameListURL) ")
            return
        }
        let gameListJsonString: NSString? = NSString(data: gameListJson!, encoding: NSUTF8StringEncoding)
        //now we have the games list in string form
        let serializedGames: NSArray? = NSJSONSerialization.JSONObjectWithData(gameListJson!, options: .allZeros, error: nil) as NSArray?
        if(serializedGames == nil)
        {
            return
        }
        var skip: Int = 0
        for gameDictionary in serializedGames!
        {
            if(skip >= 700)
            {
            let gameID: String = gameDictionary["id"]as String
            let name: String  = gameDictionary["name"] as String
            let status: String = gameDictionary["status"] as String
            
            var tempGame: serverGame = serverGame(_id: gameID, _name: name, _status: status)
            serverGames[globalCounter++] = tempGame
            }
            else
            {
                skip++
            }
        }
        
        
    }
    
    func getDetailsForGameAtIndex(index: Int) -> gameSummary
    {
        var gS: gameSummary = gameSummary(_name: "fail", _player1: "fail", _player2: "fail", _winner: "fail", _missilesLaunched: 0)
        let gameID: String = serverGames[index]!.id
        let getURL: String = "http://battleship.pixio.com/api/v2/lobby/"+gameID
        let gameDetailURL: NSURL = NSURL(string: getURL)!
        
        let summaryData: NSData? = NSData(contentsOfURL: gameDetailURL)
        if(summaryData == nil)
        {
            return gS
        }
        let serializedGame: NSDictionary? = NSJSONSerialization.JSONObjectWithData(summaryData!, options: .allZeros, error: nil) as NSDictionary?
        
        if(serializedGame == nil)
        {
            return gS
        }
        gS.name = serializedGame!["name"] as String
        gS.player1 = serializedGame!["player1"]as String
        gS.player2 = serializedGame!["player2"] as String
        
        gS.winner = serializedGame!["winner"] as String
        gS.missilesLaunched = serializedGame!["missilesLaunched"] as Int
        
        return gS
        
    }
    
    func getBoardsForPlayersInGame(GameID: String, PlayerID: String) -> NSMutableDictionary
    {
        var gameBoardURL: NSURL = NSURL(string:"http://battleship.pixio.com/api/v2/games/\(GameID)/boards?playerId=\(PlayerID)")!
        let gameBoardJson: NSData? = NSData(contentsOfURL: gameBoardURL)
        
        var boardDictionary: NSMutableDictionary = NSMutableDictionary()
        if(gameBoardJson == nil)
        {
            return boardDictionary
        }
        let gameBoardJsonString: NSString? = NSString(data: gameBoardJson!, encoding: NSUTF8StringEncoding)
        
        
        let gameDict: NSDictionary? = NSJSONSerialization.JSONObjectWithData(gameBoardJson!, options: .allZeros, error: nil) as NSDictionary?
        
        if(gameDict == nil)
        {
            return boardDictionary
        }

        let playerBoard = gameDict!["playerBoard"] as NSArray
        let opponentBoard = gameDict!["opponentBoard"] as NSArray
    
        
        var playerGrid: ShipGrid = ShipGrid()
        var opponentGrid: ShipGrid = ShipGrid()
        
        /* 
        status ENUM: HIT , MISS , NONE
        HIT: a player has hit this cell
        MISS: a player has missed this cell
        SHIP: this cell is part of a ship and has not been hit
        NONE: this cell has no activity
        */
        for entry in playerBoard
        {
            var what = entry as NSDictionary
            var col: Int = entry["xPos"] as Int
            var row: Int = entry["yPos"] as Int
            if(entry["status"] as NSString == "NONE")
            {
                
                playerGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "e")
            }
            else
            {
            
            if(entry["status"] as NSString == "SHIP")
            {

                playerGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "s")
            }
            if(entry["status"] as NSString == "HIT")
            {
    
                playerGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "h")
            }
            if(entry["status"] as NSString == "MISS")
            {
        
            playerGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "m")
            }
            }
        }
        for entry in opponentBoard
            {
                var what = entry as NSDictionary
                var col: Int = entry["xPos"] as Int
                var row: Int = entry["yPos"] as Int
                if(entry["status"] as NSString == "NONE")
            {
                    
                    opponentGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "e")
            }
                else
            {
                        
                        if(entry["status"] as NSString == "SHIP")
            {
                    
                    opponentGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "s")
                        }
                        if(entry["status"] as NSString == "HIT")
            {
                        
                        opponentGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "h")
                        }
                        
                        if(entry["status"] as NSString == "MISS")
            {
                            
                            opponentGrid.SetContentsOfGridCellWithIntRow(row, col: col, contents: "m")
                        }
                }
        }
        
       
        boardDictionary["playerBoard"] = playerGrid
        boardDictionary["opponentBoard"] = opponentGrid
      
        return boardDictionary
    }

    
    func writeGamesDictionaryToFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battleShipGameInfo.txt")
        var arr: NSMutableArray = []
        
        //add all the game saves to the master array
        for entry in myGamesDictionary
        {
            arr.addObject(entry)
        }
        
        //write to disk
        arr.writeToFile(filePath!, atomically: true)
    }
    

    
    
    func loadGameIDsFromFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battleShipGameInfo.txt")
        //load in the file to memory
        let fileText = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        myGamesDictionary = []
        var readArray: NSArray? = NSArray(contentsOfFile: filePath!)
        if let activeArray = readArray
        {
            
            for(var i=0; i < activeArray.count; i++)
            {
                var readDict: NSDictionary = activeArray[i] as NSDictionary
                
                //add all the read in game saves to the master array
               myGamesDictionary.addObject(readDict)
            }
            
           
        }
        
    }

   

    
    
    
    
}

class serverGame
{
    var id: String
    var name: String
    var status: String
    
    init(_id:String, _name:String, _status:String)
    {
        id = _id
        name = _name
        status = _status
        
    }
}


class gameSummary
{
    var name: String = ""
    var player1: String = ""
    var player2: String = ""
    var winner: String = ""
    var missilesLaunched: Int = 0
    
    init (_name: String, _player1: String, _player2: String, _winner:String, _missilesLaunched: Int)
    {
        name = _name
        player1 = _player1
        player2 = _player2
        winner = _winner
        missilesLaunched = _missilesLaunched
    }
}

    