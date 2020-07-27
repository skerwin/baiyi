//
//  Cache.swift
//  BossJob
//
//  Created by zhaoyuanjing on 2017/12/15.
//  Copyright © 2017年 zhaoyuanjing. All rights reserved.
//

import Foundation
import Cache

struct Cache {
      class CacheManager {
        static let sharedInstance: Storage? = {
            let diskConfig = DiskConfig( // The name of disk storage, this will be used as folder name within directory
                name: "Floppy",
                // Expiry date that will be applied by default for every added object
                // if it's not overridden in the `setObject(forKey:expiry:)` method
                expiry: .date(Date().addingTimeInterval(2*3600)),
                // Maximum size of the disk cache storage (in bytes)
                maxSize: 10000,
                // Where to store the disk cache. If nil, it is placed in `cachesDirectory` directory.
                directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                        appropriateFor: nil, create: true).appendingPathComponent("MyPreferences"),
                // Data protection is used to store files in an encrypted format on disk and to decrypt them on demand
                protectionType: .complete)
            let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
            return try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        }()
   }
}
