//
//  FileManager_Extension.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/24/20.
//

import Foundation

extension FileManager {
    
    // File Handling
    // ----------------------------------------------------
    
    // Returns a base path to the Document Directory.
    func documentDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0];
    }
    
    func documentsDirectory() -> URL {
        let paths = self.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        return paths[0]
    }

    
    // Creates a directory tree for a file/directory path.
   func createFilePath(path:String) throws {
        let fileManager:FileManager = FileManager.default;
        try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil);
    }
    
    // Returns whether a file exists at the given path.
    func fileExistsAtPath(path:String?) -> Bool {
        if (path == nil) { return false; }
        if (FileManager.default.fileExists(atPath: path!) == true) { return true; }
        else { return false; }
    }
    
    // Returns a filepath to a file directly within the Document Directory.
    func pathFromDocumentDirectory(filename:String, fileExtension:String) -> String {
        var fullFilePath:String = filename + fileExtension;
        fullFilePath = (self.documentDirectory() as NSString).appendingPathComponent(fullFilePath);
        return fullFilePath;
    }
    
    // Loads a plist from the app bundle.
    func plistFromBundle(filename:String) -> NSDictionary? {
        if let bundle:String = Bundle.main.path(forResource: filename, ofType: "plist") {
            let fileManager:FileManager = FileManager.default;
            if (fileManager.fileExists(atPath: bundle)) { return NSDictionary(contentsOfFile: bundle); }
        }
        return nil;
    }
    
    // Loads a plist from the Document Directory, potentially falling back to the app bundle.
    func plistFromDocumentDirectory(filename:String, fallbackToBundle:Bool) -> NSDictionary? {
        let fullFileName:String = self.pathFromDocumentDirectory(filename: filename, fileExtension: ".plist");
        let fileManager:FileManager = FileManager.default;
        if (!fileManager.fileExists(atPath: fullFileName)) {
            if (fallbackToBundle == true) { return self.plistFromBundle(filename: filename); }
            else { return nil; }
        }
        else { return NSDictionary(contentsOfFile: fullFileName); }
    }
    
    // Loads a plist from the sepcified file path.
    func plist(filePath:String) -> NSDictionary? {
        let path:String = filePath + ".plist";
        let fileManager:FileManager = FileManager.default;
        if (!fileManager.fileExists(atPath: path)) { return nil; }
        else { return NSDictionary(contentsOfFile: path); }
    }
    
    // CONVENIENCE - Saves a plist to the Document Directory.
    func savePlistToDocumentDirectory(dataDictionary:[String:Any], fileName:String) {
        self.savePlist(dataDictionary: dataDictionary, filePath: self.documentDirectory() + "/\(fileName)");
    }
    
    // Saves a plist to a specified file path.
    func savePlist(dataDictionary:[String:Any], filePath:String) {
        let path:String = filePath + ".plist";
        let objectDictionary:NSDictionary = dataDictionary as NSDictionary;
        let result:Bool = objectDictionary.write(toFile: path, atomically: true);
        #if DEBUG
            if (result == true) { print("AppManager - Saving \((path as NSString).lastPathComponent) successful!"); }
            else { print("AppManager - Saving \((path as NSString).lastPathComponent) failed!"); }
        #endif
    }
    
    // Removes a file or directory at a given filepath.
    func removeFileAtPath(filePath:String) -> Bool {
        let fileManager:FileManager = FileManager.default;
        do {
            try fileManager.removeItem(atPath: filePath);
            return true;
        }
        catch { return false; }
    }
    
    // Returns the path where images are stored. The directory will be created if it doesn't exist.
    func imagePath(filename:String) -> String {
        
        let imageDirectory:String = self.documentDirectory() + "/images/";
        
        // Create directory if it doesn't exist
        let fileManager:FileManager = FileManager.default;
        if (!fileManager.fileExists(atPath: imageDirectory)) {
            do { try fileManager.createDirectory(atPath: imageDirectory, withIntermediateDirectories: true, attributes: nil); }
            catch _ {};
        }
        
        return imageDirectory + filename;
    }
    
    func imageExists(filename:String) -> Bool {
        let imagePath:String = self.imagePath(filename: filename);
        
        // Create directory if it doesn't exist
        let fileManager:FileManager = FileManager.default;
        if (!fileManager.fileExists(atPath: imagePath)) { return false; }
        return true;
    }
    
    // Returns the path where cached images are stored. The directory will be created if it doesn't exist.
    func imageCachePath(filename:String) -> String {
        
        let imageDirectory:String = self.documentDirectory() + "/ImageCache/";
        
        // Create directory if it doesn't exist
        let fileManager:FileManager = FileManager.default;
        if (!fileManager.fileExists(atPath: imageDirectory)) {
            do { try fileManager.createDirectory(atPath: imageDirectory, withIntermediateDirectories: true, attributes: nil); }
            catch _ {};
        }
        
        return imageDirectory + filename;
    }
    
    // Returns the path where cache config files are stored. The directory will be created if it doesn't exist.
    func cacheConfigPath(filename:String) -> String {
        
        let cacheConfigDirectory:String = self.documentDirectory() + "/CacheConfigs/";
        
        // Create directory if it doesn't exist
        let fileManager:FileManager = FileManager.default;
        if (!fileManager.fileExists(atPath: cacheConfigDirectory)) {
            do { try fileManager.createDirectory(atPath: cacheConfigDirectory, withIntermediateDirectories: true, attributes: nil); }
            catch _ {};
        }
        
        return cacheConfigDirectory + filename;
    }
    
}
