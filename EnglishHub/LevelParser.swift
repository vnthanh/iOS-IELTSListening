//
//  LevelParser.swift
//  ielts-listening
//
//  Created by Binh Le on 5/13/16.
//  Copyright © 2016 Binh Le. All rights reserved.
//

import UIKit

class LevelParser:NSObject, NSXMLParserDelegate {
    
    var lessonObject:LessonObject?
    var questionObject:QuestionObject?
    var answerObject:AnswerObject?
    
    var lessonArray = NSMutableArray()
    var lesson:String?
    var lessonId:String?
    var lessonName:String?
    var lessonPath:String?
    var sentences = NSMutableArray()
    var sentence:String?
    var questions = NSMutableArray()
    var question:String?
    var answers = NSMutableArray()
    var answer:String?
    
    func getLessonList(levelId:String) -> NSMutableArray {
        return self.beginParsing(levelId)
    }
    
    func beginParsing(selectedLevel:String) -> NSMutableArray {
        var level:String = "basic"
        if selectedLevel == "2" {
            level = "intermediate"
        }
        else if selectedLevel == "3" {
            level = "advance"
        }
        let path = NSBundle.mainBundle().pathForResource(level, ofType: "xml")
        let parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: path!))!
        parser.delegate = self
        parser.parse()
        return self.lessonArray
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        lesson = elementName
        if elementName == "lessions" {
            self.lessonArray = NSMutableArray()
        }
        else if elementName == "lession" {
            self.lessonObject = LessonObject()
            self.lessonId = ""
            self.lessonName = ""
            self.lessonPath = ""
        }
        else if elementName == "sentences_list" {
            self.sentences = NSMutableArray()
        }
        else if elementName == "sentence" {
            self.sentence = ""
        }
        else if elementName == "questionaire" {
            self.questions = NSMutableArray()
        }
        else if elementName == "questions" {
            self.questionObject = QuestionObject()
            self.question = ""
        }
        else if elementName == "answers" {
            self.answers = NSMutableArray()
        }
        else if elementName == "answer" {
            self.answerObject = AnswerObject()
            self.answer = ""
            self.answerObject?.answerValue = Int(attributeDict["value"]!)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if lesson! == "id" {
            self.lessonId! += string
        }
        else if lesson! == "name" {
            self.lessonName! += string
        }
        else if lesson! == "sound" {
            self.lessonPath! += string
        }
        else if lesson! == "sentence" {
            self.sentence! += string
        }
        else if lesson! == "question" {
            self.question! += string
        }
        else if lesson! == "answer" {
            self.answer! += string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "lession" {
            self.lessonObject!.lessonId = self.stringProcessing(self.lessonId!)
            self.lessonObject!.lessonName = self.stringProcessing(self.lessonName!)
            self.lessonObject!.lessonPath = self.stringProcessing(self.lessonPath!)
            self.lessonArray.addObject(self.lessonObject!)
        }
        else if elementName == "sentence" {
            self.sentences.addObject(self.stringProcessing(self.sentence!))
        }
        else if elementName == "sentences_list" {
            self.lessonObject!.conversationArray = self.sentences
        }
        else if elementName == "questions" {
            self.questionObject?.questionText = self.stringProcessing(self.question!)
            self.questions.addObject(self.questionObject!)
        }
        else if elementName == "answer" {
            self.answerObject?.answerText = self.stringProcessing(self.answer!)
            self.answers.addObject(self.answerObject!)
        }
        else if elementName == "answers" {
            self.questionObject?.answerArray = self.answers
        }
        else if elementName == "questionaire" {
            self.lessonObject?.questionArray = self.questions
        }
    }
    
    func stringProcessing(string:String) -> String {
        var trimmedString = string.stringByReplacingOccurrencesOfString("\n", withString: "")
        trimmedString = trimmedString.stringByReplacingOccurrencesOfString("\t", withString: "")
        trimmedString = trimmedString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return trimmedString
    }
    
}