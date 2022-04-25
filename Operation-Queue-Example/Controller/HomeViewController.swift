//
//  HomeViewController.swift
//  Operation-Queue-Example
//
//  Created by Mac on 16/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let blockOperation = BlockOperation {
//            print("Executing!")
//        }
//
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        
        
        let contentImportOperation1 = ContentImportOperation(name: "Shanmugam", sleep: 10)
        let contentImportOperation2 = ContentImportOperation(name: "Raja", sleep:  5)
        
//        queue.addOperation {
//            print("New Operation 3 Start")
//            sleep(7)
//            print("New Operation 3")
//        }
        
        contentImportOperation2.addDependency(contentImportOperation1)
        queue.addOperations([contentImportOperation1, contentImportOperation2], waitUntilFinished: true)
        
        queue.addOperation {
            sleep(1)
            print("New Operation 1")
        }
        queue.addOperation {
            sleep(2)
            print("New Operation 2")
        }
        // queue.waitUntilAllOperationsAreFinished()
        print("All done")
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel tapped")
    }
}

class ContentImportOperation: Operation {
    var operationName: String = ""
    var sleepTime: Int = 0
    convenience init(name: String, sleep: Int) {
        self.init()
        sleepTime = sleep
        operationName = name
    }

    override func main() {
        guard !isCancelled else { print(operationName, "canceled this operation!"); return }
        print(operationName, "Importing content..")
        sleep(UInt32(sleepTime))
        print(self.operationName, "Finished!")
    }
}
