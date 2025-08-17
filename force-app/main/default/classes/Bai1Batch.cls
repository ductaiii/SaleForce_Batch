// 1. In ra tất cả Account
// Mục tiêu: Làm quen với batch cơ bản.

// start: Query SELECT Id, Name FROM Account
// execute: System.debug(Name)
// finish: In ra "Hoàn thành batch in Account"
global with sharing class Bai1Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Truy vấn đối tượng Account
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        for (SObject s : scope) {
            Account acc = (Account)s;
            System.debug(acc.Name);
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Hoàn thành batch in Account ..');
    }


}

// dữ liệu test
// Bai1Batch b1 = new Bai1Batch();
// Database.executeBatch(b1, 200);