// 8. Chia nhỏ batch size và so sánh kết quả
// Mục tiêu: Hiểu batch size ảnh hưởng thế nào.

// start: Query Account
// execute: Debug "Scope size: " + scope.size()
// Khi chạy thử: Thay batch size 10, 200, 2000 để quan sát log
global with sharing class Bai8Batch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        System.debug('Scope size: ' + scope.size());
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Batch process completed.');
    }
}
//test
// Bai8Batch batch = new Bai8Batch();
// Database.executeBatch(batch,10);