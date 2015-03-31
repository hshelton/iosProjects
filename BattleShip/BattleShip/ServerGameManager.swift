//
//  GameManager.swift
//  NetworkedBattleship
//
//  Created by Hayden Shelton on 3/29/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation


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

class ServerGameManager
{
    //the server gives us an array of JSON objects which represent games
    private var serverGames: [Int: serverGame] = [:] //order created to server game
    var globalCounter = 0
    var playerGUIDs: [String] = [] //these are my games
    var gameGUIDs: [String] = [] //these are my player ids
    
    init()
    {
        loadPlayerIDsFromFile()
        loadGameIDsFromFile()
    }
    
    
    struct serverGame
    {
        var id: String
        var name: String
        var status: String
    }
    
    //checks to see if the game in question is one of your own
    func isMyGame(id: String) -> Bool
    {
        for r in gameGUIDs
        {
            if(r == id)
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
        var sG = serverGame(id: "0", name: "", status: "")
        let gameID: String = gameGUIDs[index]
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
    
    func getMyGameCount() -> Int
    {
        return gameGUIDs.count
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
            
           self.playerGUIDs.append(responsePlayerID)
            self.gameGUIDs.append(responseGameID)
            
        }
        
        
        task.resume()
        writeGameIDsToFile()
        writePlayerIDsToFile()
    }
    
    func refreshGamesList()
    {
        refreshGamesList(0)
    }
    
    func refreshMyGamesList()
    {
        loadPlayerIDsFromFile()
        loadGameIDsFromFile()
    }
    //this function pulls in the games list from the server
    func refreshGamesList(offset: Int)
    {
        let gameListURL: NSURL = NSURL(string:"http://battleship.pixio.com/api/v2/lobby?offset=\(offset)&results=1000")!
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
        for gameDictionary in serializedGames!
        {
            let gameID: String = gameDictionary["id"]as String
            let name: String  = gameDictionary["name"] as String
            let status: String = gameDictionary["status"] as String
            
            var tempGame: serverGame = serverGame(id: gameID, name: name, status: status)
            serverGames[globalCounter++] = tempGame
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
        playerGUIDs.append(idReturned)
        gameGUIDs.append(gameID)
        
        writeGameIDsToFile()
        loadGameIDsFromFile()
        writePlayerIDsToFile()
        loadPlayerIDsFromFile()
    }
    
    func writePlayerIDsToFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battlePlayerInfo.txt")
        var arr: NSMutableArray = []
        
        //add all the playerIDs to the master array
        for entry in playerGUIDs
        {
            arr.addObject(entry)
        }
        
        //write to disk
        arr.writeToFile(filePath!, atomically: true)
        
    }
    
    func writeGameIDsToFile()
    {
        
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battleGameInfo.txt")
        var arr: NSMutableArray = []
        
        //add all the game saves to the master array
        for entry in gameGUIDs
        {
            arr.addObject(entry)
        }

        //write to disk
        arr.writeToFile(filePath!, atomically: true)
    }
    
    
    func loadGameIDsFromFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battleGameInfo.txt")
        //load in the file to memory
        let fileText = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        gameGUIDs = []

        var readArray: NSArray? = NSArray(contentsOfFile: filePath!)
        if let activeArray = readArray
        {
            
            for(var i=0; i < activeArray.count; i++)
            {
                var readString: String = activeArray[i] as String
               gameGUIDs.append(readString)
            }
        }

    }

    func loadPlayerIDsFromFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battlePlayerInfo.txt")
        //load in the file to memory
        let fileText = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
       playerGUIDs = []
        
        var readArray: NSArray? = NSArray(contentsOfFile: filePath!)
        if let activeArray = readArray
        {
            
            for(var i=0; i < activeArray.count; i++)
            {
                var readString: String = activeArray[i] as String
                playerGUIDs.append(readString)
            }
        }
        
    }

    
    
    
    
}

    