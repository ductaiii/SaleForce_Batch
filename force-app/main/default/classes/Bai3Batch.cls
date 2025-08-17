// 3. Xóa Lead có Closed - Not Converted'
// Mục tiêu: Batch delete.

// start: Query SELECT Id FROM Lead WHERE Status = 'Closed - Not Converted'
// execute: delete scope
// finish: Log "Đã xóa xong Lead Closed - Not Converted"

global with sharing class Bai3Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM Lead WHERE Status = \'Closed - Not Converted\'');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        delete scope;
        system.debug('Đã xóa xong Lead Closed - Not Converted');
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Đã xóa xong Lead Closed - Not Converted');
    }
}
//test delete
// Bai3Batch b3 = new Bai3Batch();
// Database.executeBatch(b3, 200);