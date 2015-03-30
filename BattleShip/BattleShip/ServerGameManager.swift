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
    init()
    {
        
    }
    
    
    struct serverGame
    {
        var id: String
        var name: String
        var status: String
    }
    
    
    
    func getGameCount() -> Int
    {
        return serverGames.count
    }
    
    func getGameForCellAtIndex(index: Int) -> serverGame
    {
        
        return serverGames[index]!
    }
    
    func addserverGameToList(sv: serverGame)
    {
        var name: String = sv.name
        serverGames[globalCounter++] = sv
    }
    
    func createGame(gameName: String, playerName: String)
    {
        
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
            println("responseString = \(responseString)")
        }
        
        //TODO: Save Game ID of newly created game
        task.resume()
    }
    
    func refreshGamesList()
    {
        refreshGamesList(0)
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
}

    