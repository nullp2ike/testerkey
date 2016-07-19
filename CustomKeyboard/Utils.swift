//
//  Utils.swift
//  TesterKey
//
//  Created by Risko Ruus on 19/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//

class Utils{
    func counterString(length: Int, posMarker: String) -> String{
        var result :String = ""
        
        var lastPos :Int = length
        
        while(lastPos > 0){
            let token: String = String(lastPos) + posMarker
            if(token.characters.count <= lastPos){
                result = result + token
            }else{
                result = result + token.substringWithRange(Range<String.Index>(token.startIndex.advancedBy(lastPos) ..< token.endIndex))
            }
            
            lastPos -= token.characters.count
        }
        result = String(result.characters.reverse())
        
        
        let new_result = Array(result.characters)
        //print(new_result)
        var output = ""
        
        var i = 0;
        var consecutiveNumbers = 0
        
        while(result.characters.count != output.characters.count){
            let char = String(new_result[i])
            
            if(Int(char) != nil){
                consecutiveNumbers += 1
                if(consecutiveNumbers > 1){
                    output.insert(Character(char), atIndex: output.startIndex.advancedBy(consecutiveNumbers - 1))
                }else{
                    output = char + output
                }
            }else{
                consecutiveNumbers = 0
                output = char + output
            }
            //print("output")
            //print(output)
            i += 1
        }
        //print("output2")
        //print(output.characters.reverse())
        return String(output.characters.reverse())
    }
}

