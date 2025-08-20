// 7. Cập nhật số lượng Contact vào custom field trên Account (Number_of_Contacts__c)
// Mục tiêu: Batch xử lý liên quan giữa nhiều object.

// start: Query SELECT Id, (SELECT Id FROM Contacts) FROM Account
// execute: Đếm số Contact và update field
// finish: Log "Hoàn thành cập nhật số lượng Contact"

global with sharing class Bai7Batch implements Database.Batchable<SObject> , Database.Stateful {
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, (SELECT Id FROM Contacts) FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        for (SObject record : scope) {
            Account acc = (Account) record;
            Integer contactCount = acc.Contacts.size();
            acc.Number_of_Contacts__c = contactCount; // Giả sử trường này đã được tạo
            update acc; // Cập nhật Account với số lượng Contact
            recordsProcessed++;
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Đã xử lý ' + recordsProcessed + ' Account và cập nhật số lượng Contact.');
    }

}
// testbai 7
// Bai7Batch batch = new Bai7Batch();
// Database.executeBatch(batch);