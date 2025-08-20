// 9. Xử lý dữ liệu lớn với QueryLocator
// Mục tiêu: Truy vấn > 50.000 record.

// start: Dùng Database.getQueryLocator('SELECT Id FROM Account')
// execute: Debug Id
// finish: Log "Xử lý dữ liệu lớn xong"

global with sharing class Bai9Batch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        for (SObject record : scope) {
            System.debug('Processing Account Id: ' + record.Id);
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Xử lý dữ liệu lớn xong');
    }
}
// test
// Bai9Batch batch = new Bai9Batch();
// Database.executeBatch(batch);