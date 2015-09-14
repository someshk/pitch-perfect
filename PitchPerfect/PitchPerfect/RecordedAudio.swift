//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Somesh Kumar on 9/14/15.
//  Copyright (c) 2015 Somesh Kumar. All rights reserved.
//

import Foundation

final class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl fileURL: NSURL!, title fileTitle: String) {
        filePathUrl = fileURL
        title = fileTitle
    }
}
