// 5. Tự động gán Industry = 'Technology' cho Account không có Industry
// Mục tiêu: Update có điều kiện.

// start: Query SELECT Id, Industry FROM Account WHERE Industry = null
// execute: Update Industry = 'Technology'
// finish: Debug tổng số record đã update

global with sharing class Bai5Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Integer recordsUpdated = 0;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id,Name, Industry FROM Account WHERE Industry = null');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        for (SObject s : scope) {
            Account acc = (Account)s;
            acc.Industry = 'Technology';
            accountsToUpdate.add(acc);
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
            for (Account acc : accountsToUpdate) {
                System.debug('Đã cập nhật Industry cho Account ID: ' + acc.Name + ' thành Technology');
            }
            recordsUpdated += accountsToUpdate.size();
        }
    }

    global void finish(Database.BatchableContext BC) {

        System.debug('Tổng số record đã update: ' + recordsUpdated);

    }
}
// test
// Bai5Batch bai5 = new Bai5Batch();
// Database.executeBatch(bai5);