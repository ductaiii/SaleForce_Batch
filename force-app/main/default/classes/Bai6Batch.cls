// 6. Gửi email sau khi batch chạy xong
// Mục tiêu: Dùng logic trong finish.

// start: Query Account
// execute: Không cần xử lý phức tạp
// finish: Tạo Messaging.SingleEmailMessage và gửi đến admin
global with sharing class Bai6Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id,Name  FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        // Không cần xử lý gì phức tạp
        recordsProcessed += scope.size();
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Đã xử lý ' + recordsProcessed + ' Account.');

        // Gửi email thông báo
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {'duct6984@gmail.com'});
        email.setSubject('Đã xử lý xong Batch');
        // email.setPlainTextBody('Đã xử lý ' + recordsProcessed + ' Account.');
        email.setHtmlBody(
    '<h2 style="color:green;">Batch Process Completed!</h2>' +
    '<p>Đã xử lý <b style="color:blue;">' + recordsProcessed + ' Account</b>.</p>' +
    '<p>Cảm ơn bạn đã sử dụng hệ thống.</p>'
);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });

        System.debug(LoggingLevel.INFO, 'Email đã được gửi đi');
    }
}

// test
// Bai6Batch bai6 = new Bai6Batch();
// Database.executeBatch(bai6);